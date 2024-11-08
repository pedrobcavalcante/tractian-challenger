import '../../data/datasource/company_datasource.dart';
import '../network/api_client.dart';

class CompanyDataSourceImpl implements CompanyDataSource {
  final ApiClient apiClient;

  CompanyDataSourceImpl(this.apiClient);

  @override
  Future<List<Map<String, dynamic>>> getCompanies() async {
    final response = await apiClient.get('/companies');
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Future<List<Map<String, dynamic>>> getLocations(String companyId) async {
    final response = await apiClient.get('/companies/$companyId/locations');
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Future<List<Map<String, dynamic>>> getAssets(String companyId) async {
    final response = await apiClient.get('/companies/$companyId/assets');
    return List<Map<String, dynamic>>.from(response);
  }
}
