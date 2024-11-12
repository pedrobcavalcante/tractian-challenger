import 'package:get/get.dart';

import '../presentation/asset_screen.dart';
import '../presentation/home_screen.dart';
import '../presentation/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String assets = '/assets';

  static List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: assets,
      page: () => AssetScreen(),
    ),
  ];
}
