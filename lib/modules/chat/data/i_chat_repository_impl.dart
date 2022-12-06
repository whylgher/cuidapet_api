import 'package:cuidapet_api/exceptions/database_exception.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import './i_chat_repository.dart';
import '../../../application/database/i_database_connection.dart';
import '../../../application/logger/i_logger.dart';

@LazySingleton(as: IChatRepository)
class IChatRepositoryImpl implements IChatRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  IChatRepositoryImpl({
    required this.connection,
    required this.log,
  });

  @override
  Future<int> startChat(int scheduleId) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final result = await conn.query('''
          INSERT INTO chats(agendamento_id, status, data_criacao)
          VALUES (?, ?, ?)
        ''', [
        scheduleId,
        'A',
        DateTime.now().toIso8601String(),
      ]);

      return result.insertId!;
    } on MySqlException catch (e, s) {
      log.error('Eroo ao iniciar chat', e, s);

      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }
}



//  MySqlConnection? conn;

//     try {
//       conn = await connection.openConnection();
//     } on MySqlException catch (e, s) {
//       log.error('message', e, s);
//       throw DatabaseException();
//     } finally {
//       await conn?.close();
//     }
//   }
