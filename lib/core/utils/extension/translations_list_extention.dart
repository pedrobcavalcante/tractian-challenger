import 'package:get/get_navigation/src/root/internacionalization.dart';

extension TranslationsListExtension on List<Translations> {
  Map<String, Map<String, String>> keysMap() {
    final translations = <String, Map<String, String>>{};
    for (final t in this) {
      for (final locale in t.keys.keys) {
        translations[locale] ??= <String, String>{};
        translations[locale]!.addAll(t.keys[locale]!);
      }
    }
    return translations;
  }
}
