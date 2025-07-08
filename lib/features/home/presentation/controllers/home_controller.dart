import 'package:get/get.dart';
import 'package:tractian/domain/entities/company.dart';
import 'package:tractian/domain/usecases/get_companies.dart';
import 'package:tractian/core/errors/exceptions.dart';

class HomeController extends GetxController {
  final GetCompanies getCompaniesUseCase;

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
