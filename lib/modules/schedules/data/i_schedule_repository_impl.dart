// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_api/entities/schedule.dart';
import 'package:cuidapet_api/exceptions/database_exception.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import './i_schedule_repository.dart';
import '../../../application/database/i_database_connection.dart';
import '../../../application/logger/i_logger.dart';

@LazySingleton(as: IScheduleRepository)
class IScheduleRepositoryImpl implements IScheduleRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  IScheduleRepositoryImpl({
    required this.connection,
    required this.log,
  });

  @override
  Future<void> save(Schedule schedule) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();

      await conn.transaction((_) async {
        final result = await conn!.query('''
          INSERT INTO agendamento
            (data_agendamento, usuario_id, fornecedor_id, status, nome, nome_pet)
          VALUES(?, ?, ?, ?, ?, ?)
          ''', [
          schedule.scheduleDate.toIso8601String(),
          schedule.userId,
          schedule.supplier.id,
          schedule.status,
          schedule.name,
          schedule.petName,
        ]);

        final scheduleId = result.insertId;

        if (scheduleId != null) {
          await conn.queryMulti(
            '''
            INSERT INTO agendamento_servicos values (?, ?)
            ''',
            schedule.services.map(
              (s) => [
                scheduleId,
                s.service.id,
              ],
            ),
          );
        }
      });
    } on MySqlException catch (e, s) {
      log.error('Erro ao agendar serviço', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }
}
