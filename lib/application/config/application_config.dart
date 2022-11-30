import 'package:dotenv/dotenv.dart' show load, env;

class ApplicationConfig {
  Future<void> loadConfigApplication() async {
    await _loadEnv();
    final variavel = env['url_banco_de_dados'];

    print(variavel);
  }

  Future<void> _loadEnv() async => load();
}
