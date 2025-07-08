import 'package:get/get.dart';

class AssetTranslations extends Translations {
  static const String title = 'asset.screen.title';
  static const String loading = 'asset.screen.loading';
  static const String errorRetry = 'asset.screen.error.retry';

  @override
  Map<String, Map<String, String>> get keys => {
    'pt_BR': {
      title: 'Ativos',
      loading: 'Carregando...',
      errorRetry: 'Erro ao carregar dados. Tente novamente.',
    },
    'en_US': {
      title: 'Assets',
      loading: 'Loading...',
      errorRetry: 'Error loading data. Try again.',
    },
  };
}
