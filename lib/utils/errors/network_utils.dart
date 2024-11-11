import 'exceptions.dart';

class NetworkUtils {
  static void handleHttpError(int statusCode) {
    switch (statusCode) {
      case 401:
        throw UnauthorizedException('Usuário não autorizado');
      case 404:
        throw NotFoundException('Recurso não encontrado');
      case 500:
        throw ServerException('Erro interno do servidor');
      default:
        throw ServerException('Erro desconhecido com status $statusCode');
    }
  }
}
