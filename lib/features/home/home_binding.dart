import 'package:get/get.dart';
import 'package:tractian/features/home/presentation/controllers/home_controller.dart';
import 'package:tractian/domain/usecases/get_companies_usecase.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCompaniesUseCase>(() => GetCompaniesUseCaseImpl(Get.find()));
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
