import 'package:get/get.dart';

import '../bindings/asset_binding.dart';
import '../bindings/home_binding.dart';
import '../presentation/screens/asset_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/splash_screen.dart';

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
      binding: HomeBinding(),
    ),
    GetPage(
      name: assets,
      page: () => AssetScreen(),
      binding: AssetBinding(),
    ),
  ];
}
