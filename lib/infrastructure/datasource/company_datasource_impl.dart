import 'dart:io';

import '../../data/datasource/company_datasource.dart';
import '../../utils/errors/exceptions.dart';
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
    try {
      final response = await apiClient.get(endpoint);

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      }
      switch (response.statusCode) {
        case 401:
          throw UnauthorizedException('Usuário não autorizado');
        case 404:
          throw NotFoundException('Recurso não encontrado');
        case 500:
          throw ServerException('Erro interno do servidor');
        default:
          throw ServerException(
              'Erro desconhecido com status ${response.statusCode}');
      }
    } on SocketException {
      throw NetworkException('Não foi possível conectar-se à rede.');
    } on FormatException {
      throw ServerException('Formato de resposta inválido do servidor.');
    } catch (e) {
      throw ServerException('Erro desconhecido: $e');
    }
  }
}
