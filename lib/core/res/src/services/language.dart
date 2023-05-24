import 'dart:convert';

import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/services.dart';

import 'local_storage_service.dart';

///language
Future<void> loadLanguage(
    {required String langKey,
    required LocalStorageService localStorageService}) async {
  /// need to emit a state

  String translation;
  String errorTranslation;
  final String langFileName = langKey == 'ar' ? 'ar_AE' : 'en_US';
  translation =
      await rootBundle.loadString('assets/localization/$langFileName.json');
  errorTranslation =
      await rootBundle.loadString('assets/errors/$langFileName.json');
  localization = jsonDecode(translation) as Map<String, dynamic>;
  errorLocalization = jsonDecode(errorTranslation) as Map<String, dynamic>;

  currentUserPermission.locale = langKey;
  currentUserPermission.language = langKey;

  await localStorageService.writeKey('lang', langKey);
  // emit(LanguageChanged());
}
