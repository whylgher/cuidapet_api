import 'package:shelf_router/src/router.dart';

import '../../application/routers/i_router.dart';
import 'teste_controller.dart';

class TesteRouter implements IRouter {
  @override
  void configure(Router router) {
    router.mount('/hello/', TesteController().router);
  }
}
