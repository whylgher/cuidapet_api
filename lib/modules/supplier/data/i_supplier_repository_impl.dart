// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_api/dtos/supplier_near_by_me_dto.dart';
import 'package:cuidapet_api/entities/supplier.dart';
import 'package:cuidapet_api/exceptions/database_exception.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';

import './i_supplier_repository.dart';
import '../../../application/database/i_database_connection.dart';
import '../../../application/logger/i_logger.dart';
import '../../../entities/category.dart';

@LazySingleton(as: ISupplierRepository)
class ISupplierRepositoryImpl implements ISupplierRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  ISupplierRepositoryImpl({
    required this.connection,
    required this.log,
  });

  @override
  Future<List<SupplierNearByMeDto>> findNearByPosition(
      double lat, double lng, int distance) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final query = ''' 
        SELECT f.id, f.nome, f.logo, f.categorias_fornecedor_id,
          (6371 *
            acos(
                            cos(radians($lat)) *
                            cos(radians(ST_X(f.latlng))) *
                            cos(radians($lng) - radians(ST_Y(f.latlng))) +
                            sin(radians($lat)) *
                            sin(radians(ST_X(f.latlng)))
                )) AS distancia
            FROM fornecedor f
            HAVING distancia <= $distance
            Order by distancia;
      ''';

      final result = await conn.query(query);

      return result
          .map(
            (f) => SupplierNearByMeDto(
                id: f['id'],
                name: f['nome'],
                logo: (f['logo'] as Blob?)?.toString(),
                distance: f['distancia'],
                categoryId: f['categorias_fornecedor_id']),
          )
          .toList();
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar fornecedores perto de mim GEO', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<Supplier> findById(int id) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();

      final query = '''
          SELECT 
            f.id, f.nome, f.logo, f.endereco, f.telefone,
            ST_X(f.latlng) as lat, ST_Y(f.latlng) as lng,
            f.categorias_fornecedor_id, c.nome_categoria, c.tipo_categoria
          FROM fornecedor AS f
            INNER JOIN categorias_fornecedor AS c ON (f.categorias_fornecedor_id = c.id)
          WHERE 
            f.id = ?
        ''';

      final result = await conn.query(query, [id]);

      if (result.isNotEmpty) {
        final dataMysql = result.first;

        return Supplier(
          id: dataMysql['id'],
          name: dataMysql['nome'],
          logo: (dataMysql['logo'] as Blob?)?.toString(),
          address: dataMysql['endereco'],
          phone: dataMysql['telefone'],
          lat: dataMysql['lat'],
          lng: dataMysql['lng'],
          category: Category(
            id: dataMysql['categorias_fornecedor_id'],
            name: dataMysql['nome_categoria'],
            type: dataMysql['tipo_categoria'],
          ),
        );
      } else {
        throw Response.internalServerError();
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar fornecedor', e, s);

      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }
}
