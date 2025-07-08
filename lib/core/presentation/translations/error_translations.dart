import 'package:get/get.dart';

class ErrorTranslations extends Translations {
  static const String serverError = 'error.server';
  static const String networkError = 'error.network';
  static const String unauthorized = 'error.unauthorized';
  static const String notFound = 'error.notFound';

  @override
  Map<String, Map<String, String>> get keys => {
        'pt_BR': {
          serverError: 'Erro no servidor',
          networkError: 'Falha na conexão de rede',
          unauthorized: 'Usuário não autorizado',
          notFound: 'Recurso não encontrado',
        },
        'en_US': {
          serverError: 'Server error',
          networkError: 'Network connection failure',
          unauthorized: 'User not authorized',
          notFound: 'Resource not found',
        },
      };
}
