import 'package:get/get.dart';

class AssetTranslations extends Translations {
  static const String title = 'asset.screen.title';
  static const String loading = 'asset.screen.loading';
  static const String errorRetry = 'asset.screen.error.retry';
  static const String emptyList = 'asset.screen.emptyList';

  @override
  Map<String, Map<String, String>> get keys => {
    'pt_BR': {
      title: 'Assets',
      loading: 'Carregando...',
      errorRetry: 'Erro ao carregar dados. Tente novamente.',
      emptyList: 'Nenhum item encontrado',
    },
    'en_US': {
      title: 'Assets',
      loading: 'Loading...',
      errorRetry: 'Error loading data. Try again.',
      emptyList: 'No items found',
    },
  };
}
