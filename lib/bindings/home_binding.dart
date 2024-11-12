import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../domain/usecases/get_companies.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Repositórios e Use Cases
    Get.lazyPut<GetCompanies>(() => GetCompanies(Get.find()));

    // Controlador
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
