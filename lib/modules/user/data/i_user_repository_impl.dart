import 'package:cuidapet_api/entities/user.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import './i_user_repository.dart';
import '../../../application/database/i_database_connection.dart';
import '../../../application/helpers/cripty_helper.dart';
import '../../../application/logger/i_logger.dart';
import '../../../exceptions/database_exception.dart';
import '../../../exceptions/user_exists_exception.dart';
import '../../../exceptions/user_not_found_exception.dart';

@LazySingleton(as: IUserRepository)
class IUserRepositoryImpl implements IUserRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  IUserRepositoryImpl({
    required this.connection,
    required this.log,
  });

  @override
  Future<User> createUser(User user) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final query = ''' 
      INSERT usuario(email, tipo_cadastro, img_avatar, senha,
        fornecedor_id, social_id)
      VALUES (?, ?, ?, ?, ?, ?)
      ''';

      final result = await conn.query(query, [
        user.email,
        user.registerType,
        user.imageAvatar,
        CriptyHelper.genereteSha256Hash(user.password ?? ''),
        user.supplierId,
        user.socialKey
      ]);

      final userId = result.insertId;
      return user.copyWith(id: userId, password: null);
    } on MySqlException catch (e, s) {
      if (e.message.contains('usuario.email_UNIQUE')) {
        log.error('Usuario ja cadastrado na base de dados', e, s);
        throw UserExistsException();
      }

      log.error('Erro ao criar usuario', e, s);
      throw DatabaseException(
        message: 'Erro ao criar usuario',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<User> loginWithEmailPassword(
      String email, String password, bool supplierUser) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();

      var query = '''
        SELECT *
        FROM usuario 
        WHERE 
          email = ?
          and senha = ?
        ''';

      if (supplierUser) {
        query += 'AND fornecedor_id IS NOT NULL';
      } else {
        query += 'AND fornecedor_id IS NULL';
      }

      final result = await conn.query(query, [
        email,
        CriptyHelper.genereteSha256Hash(password),
      ]);

      if (result.isEmpty) {
        log.error('Usuário ou senha inválidos');
        throw UserNotFoundException(message: 'Usuário ou senha inválidos');
      } else {
        final userSqlData = result.first;
        return User(
          id: userSqlData['id'] as int,
          email: userSqlData['email'],
          registerType: userSqlData['tipo_cadastro'],
          iosToken: (userSqlData['ios_token'] as Blob?)?.toString(),
          androidToken: (userSqlData['android_token'] as Blob?)?.toString(),
          refreshToken: (userSqlData['refresh_token'] as Blob?)?.toString(),
          imageAvatar: (userSqlData['img_avatar'] as Blob?)?.toString(),
          supplierId: userSqlData['fornecedor_id'],
        );
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao realizar login', e, s);
      throw DatabaseException(message: e.message);
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<User> loginByEmailSocialKey(
      String email, String socialKey, String socialType) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();

      final result = await conn.query('''
          SELECT * 
          FROM usuario 
          WHERE email = ?
       ''', [email]);

      if (result.isEmpty) {
        throw UserNotFoundException(message: 'Usuário não encontrado');
      } else {
        final dataMysql = result.first;
        if (dataMysql['social_id'] == null ||
            dataMysql['social_id'] != socialKey) {
          await conn.query(''' 
            UPDATE usuario 
            SET social_id = ?, tipo_cadastro = ?
            WHERE id = ?
          ''', [socialKey, socialType, dataMysql['id']]);
        }

        return User(
          id: dataMysql['id'] as int,
          email: dataMysql['email'],
          registerType: dataMysql['tipo_cadastro'],
          iosToken: (dataMysql['ios_token'] as Blob?)?.toString(),
          androidToken: (dataMysql['android_token'] as Blob?)?.toString(),
          refreshToken: (dataMysql['refresh_token'] as Blob?)?.toString(),
          imageAvatar: (dataMysql['img_avatar'] as Blob?)?.toString(),
          supplierId: dataMysql['fornecedor_id'],
        );
      }
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> updateUserDeviceTokenAndRefreshToken(User user) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();

      final setParams = {};

      if (user.iosToken != '' || user.iosToken != null) {
        setParams.putIfAbsent('ios_token', () => user.iosToken);
      } else {
        setParams.putIfAbsent('android_token', () => user.androidToken);
      }

      final query = ''' 
      UPDATE usuario
      SET 
        ${setParams.keys.elementAt(0)} = ?,
        refresh_token = ?
      WHERE 
        id = ?
      ''';

      await conn.query(query, [
        setParams.values.elementAt(0),
        user.refreshToken!,
        user.id!,
      ]);
    } on MySqlException catch (e, s) {
      log.error('Erro ao confirmar login', e, s);
      throw DatabaseException(message: e.message);
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> updateRefreshToken(User user) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      await conn.query(''' 
        UPDATE usuario
        SET refresh_token = ?
        WHERE id = ?
      ''', [
        user.refreshToken!,
        user.id!,
      ]);
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<User> findById(int id) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final result = await conn.query('''
        SELECT id, email, tipo_cadastro, ios_token, android_token,
          refresh_token, img_avatar, fornecedor_id
        FROM usuario
        WHERE id = ?
      ''', [id]);

      if (result.isEmpty) {
        log.error('Usuário não encontrado com o id: $id');
        throw UserNotFoundException(
            message: 'Usuário não encontrado com o id: $id');
      } else {
        final dataMysql = result.first;

        return User(
          id: dataMysql['id'] as int,
          email: dataMysql['email'],
          registerType: dataMysql['tipo_cadastro'],
          iosToken: (dataMysql['ios_token'] as Blob?)?.toString(),
          androidToken: (dataMysql['android_token'] as Blob?)?.toString(),
          refreshToken: (dataMysql['refresh_token'] as Blob?)?.toString(),
          imageAvatar: (dataMysql['img_avatar'] as Blob?)?.toString(),
          supplierId: dataMysql['fornecedor_id'],
        );
      }
    } finally {
      await conn?.close();
    }
  }
}
