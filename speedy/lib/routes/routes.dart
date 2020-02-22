import 'package:fluro/fluro.dart';
import 'package:speedy/routes/route_handler.dart';

class Routes {
  static const splash = '/';

  static void configureRouter(Router router) {
    router.define(splash,
        handler: splashHandler, transitionType: TransitionType.native);
  }
}
