import 'exceptions.dart';
import 'package:tractian/core/presentation/translations/error_translations.dart';

class NetworkUtils {
  static void handleHttpError(int statusCode) {
    switch (statusCode) {
      case 401:
        throw UnauthorizedException(ErrorTranslations.unauthorized);
      case 404:
        throw NotFoundException(ErrorTranslations.notFound);
      case 500:
        throw ServerException(ErrorTranslations.serverError);
      default:
        throw ServerException('${ErrorTranslations.serverError}: $statusCode');
    }
  }
}
