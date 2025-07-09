import 'package:get/get.dart';
import 'package:tractian/core/presentation/translations/error_translations.dart';
import 'package:tractian/core/utils/extension/translations_list_extention.dart';
import 'package:tractian/features/asset/presentation/localization/asset_translations.dart';

import '../translations/shared_translations.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      [
        SharedTranslations(),
        ErrorTranslations(),
        AssetTranslations(),
      ].keysMap();
}
