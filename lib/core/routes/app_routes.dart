import 'package:get/get.dart';
import 'package:tractian/features/asset/asset_binding.dart';
import 'package:tractian/features/home/home_binding.dart';
import 'package:tractian/core/constants/route_names.dart';
import 'package:tractian/presentation/screens/asset_screen.dart';
import 'package:tractian/features/home/presentation/screen/home_screen.dart';
import 'package:tractian/presentation/screens/splash_screen.dart';

class AppRoutes {
  static List<GetPage> getPages = [
    GetPage(name: RoutesPage.splash, page: () => const SplashScreen()),
    GetPage(
      name: RoutesPage.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RoutesPage.assets,
      page: () => AssetScreen(),
      binding: AssetBinding(),
    ),
  ];
}
