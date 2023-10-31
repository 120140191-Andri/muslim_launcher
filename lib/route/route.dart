import 'package:get/get.dart';
import 'package:muslim_launcher/view/homePage.dart';
import 'package:muslim_launcher/view/menuApps.dart';

appRoutes() => [
      GetPage(
        name: '/home',
        page: () => const HomePage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/menuApps',
        page: () => const MenuApps(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {}
