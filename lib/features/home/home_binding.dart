import 'package:get/get.dart';
import 'package:tractian/controllers/home_controller.dart';
import 'package:tractian/domain/usecases/get_companies.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCompanies>(() => GetCompanies(Get.find()));
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
