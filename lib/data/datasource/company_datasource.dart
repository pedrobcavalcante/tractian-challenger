abstract class CompanyDataSource {
  Future<List<Map<String, dynamic>>> getCompanies();
  Future<List<Map<String, dynamic>>> getLocations(String companyId);
  Future<List<Map<String, dynamic>>> getAssets(String companyId);
}
