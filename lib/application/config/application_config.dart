import 'package:dotenv/dotenv.dart' show load, env;
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../logger/i_logger.dart';
import '../logger/i_logger_impl.dart';
import '../routers/router_configure.dart';
import 'database_connection_configuration.dart';
import 'service_locator_config.dart';

class ApplicationConfig {
  Future<void> loadConfigApplication(Router router) async {
    await _loadEnv();
    _loadDataBaseConfig();
    _configLogger();
    _loadDependencies();
    _loadRoutersConfigure(router);
  }

  Future<void> _loadEnv() async => load();

  void _loadDataBaseConfig() {
    final databaseConfig = DatabaseConnectionConfiguration(
      host: '139.162.201.203',
      user: 'whylgher',
      port: 3306,
      password: 'Mwl3\$P78@',
      databaseName: 'cuidapet_db',
    );
    GetIt.I.registerSingleton(databaseConfig);
  }

  void _configLogger() =>
      GetIt.I.registerLazySingleton<ILogger>(() => ILoggerImpl());

  void _loadDependencies() => configureDependencies();

  void _loadRoutersConfigure(Router router) =>
      RouterConfigure(router).configure();
}
