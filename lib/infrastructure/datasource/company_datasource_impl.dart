import 'dart:io';

import 'package:tractian/core/data/network/api_client.dart';
import 'package:tractian/data/datasource/company_datasource.dart';
import 'package:tractian/utils/errors/exceptions.dart';

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
    try {
      final response = await apiClient.get(endpoint);

      return List<Map<String, dynamic>>.from(response);
    } on SocketException {
      throw NetworkException('Não foi possível conectar-se à rede.');
    } on FormatException {
      throw ServerException('Formato de resposta inválido do servidor.');
    } catch (e) {
      throw ServerException('Erro desconhecido: $e');
    }
  }
}
