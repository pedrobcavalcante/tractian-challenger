class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Erro no servidor']);
}

class NetworkException implements ServerException {
  @override
  final String message;
  NetworkException([this.message = 'Falha na conexão de rede']);
}

class UnauthorizedException implements ServerException {
  @override
  final String message;
  UnauthorizedException([this.message = 'Usuário não autorizado']);
}

class NotFoundException implements ServerException {
  @override
  final String message;
  NotFoundException([this.message = 'Recurso não encontrado']);
}
