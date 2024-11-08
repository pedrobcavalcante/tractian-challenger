class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Erro no servidor']);
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Falha na conexão de rede']);
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException([this.message = 'Usuário não autorizado']);
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException([this.message = 'Recurso não encontrado']);
}
