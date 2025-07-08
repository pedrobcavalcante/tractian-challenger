import 'package:tractian/core/presentation/translations/error_translations.dart';

class ServerException implements Exception {
  final String message;
  ServerException([this.message = ErrorTranslations.serverError]);
}

class NetworkException extends ServerException {
  NetworkException([super.message = ErrorTranslations.networkError]);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException([super.message = ErrorTranslations.unauthorized]);
}

class NotFoundException extends ServerException {
  NotFoundException([super.message = ErrorTranslations.notFound]);
}
