import 'dart:io';

import '../../data/datasource/company_datasource.dart';
import '../../utils/errors/exceptions.dart';
import '../../utils/errors/network_utils.dart';
import '../network/api_client.dart';

class CompanyDataSourceImpl implements CompanyDataSource {
  static const String _companiesEndpoint = '/companies';

  final ApiClient apiClient;

  CompanyDataSourceImpl(this.apiClient);

  @override
  Future<List<Map<String, dynamic>>> getCompanies() async {
    return await _getRequest(_companiesEndpoint);
  }

  @override
  Future<List<Map<String, dynamic>>> getLocations(String companyId) async {
    return await _getRequest('$_companiesEndpoint/$companyId/locations');
  }

  @override
  Future<List<Map<String, dynamic>>> getAssets(String companyId) async {
    return await _getRequest('$_companiesEndpoint/$companyId/assets');
  }

  Future<List<Map<String, dynamic>>> _getRequest(String endpoint) async {
    late final int statusCode;
    try {
      final response = await apiClient.get(endpoint);
      statusCode = response.statusCode;
      if (statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      }
      NetworkUtils.handleHttpError(statusCode);
    } on SocketException {
      throw NetworkException('Não foi possível conectar-se à rede.');
    } on FormatException {
      throw ServerException('Formato de resposta inválido do servidor.');
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Erro desconhecido: $e');
    }
    throw ServerException('Erro desconhecido.');
  }
}
