import 'package:dotenv/dotenv.dart' show load, env;
import 'package:get_it/get_it.dart';

import '../logger/i_logger.dart';
import '../logger/i_logger_impl.dart';
import 'database_connection_configuration.dart';
import 'service_locator_config.dart';

class ApplicationConfig {
  Future<void> loadConfigApplication() async {
    await _loadEnv();
    _loadDataBaseConfig();
    _configLogger();
    _loadDependencies();
  }

  Future<void> _loadEnv() async => load();

  void _loadDataBaseConfig() {
    final databaseConfig = DatabaseConnectionConfiguration(
      host: env['DATABASE_HOST'] ?? env['databaseHost']!,
      user: env['DATABASE_USER'] ?? env['databaseUser']!,
      port: int.tryParse(env['DATABASE_PORT'] ?? env['databasePort']!) ?? 0,
      password: env['DATABASE_PASSWORD'] ?? env['databasePassword']!,
      databaseName: env['DATABASE_NAME'] ?? env['databaseName']!,
    );
    GetIt.I.registerSingleton(databaseConfig);
  }

  void _configLogger() =>
      GetIt.I.registerLazySingleton<ILogger>(() => ILoggerImpl());

  void _loadDependencies() => configureDependencies();
}
