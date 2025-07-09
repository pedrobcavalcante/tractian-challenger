import 'package:get/get.dart';
import 'package:tractian/features/asset/domain/entities/company.dart';
import 'package:tractian/features/home/domain/usecases/get_companies_usecase.dart';
import 'package:tractian/core/errors/exceptions.dart';

class HomeController extends GetxController {
  final GetCompaniesUseCase getCompaniesUseCase;

  var units = <Company>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  HomeController(this.getCompaniesUseCase);

  @override
  void onInit() {
    super.onInit();
    fetchUnits();
  }

  void fetchUnits() async {
    isLoading(true);
    errorMessage.value = '';
    try {
      units.value = await getCompaniesUseCase();
    } on ServerException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'Erro desconhecido: $e';
    } finally {
      isLoading(false);
    }
  }
}
