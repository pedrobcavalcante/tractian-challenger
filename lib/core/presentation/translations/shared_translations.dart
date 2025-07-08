import 'package:get/get.dart';

class SharedTranslations extends Translations {
  static const String dropdownNotInformed = 'shared.dropdown.notInformed';
  static const String snackbarError = 'shared.snackbar.error';
  static const String unexpectedError = 'shared.unexpected.error';

  @override
  Map<String, Map<String, String>> get keys => {
    'pt_BR': {
      dropdownNotInformed: 'Não informado',
      snackbarError: 'Erro',
      unexpectedError: 'Erro inesperado',
    },
    'en_US': {
      dropdownNotInformed: 'Not informed',
      snackbarError: 'Error',
      unexpectedError: 'Unexpected error',
    },
  };
}
