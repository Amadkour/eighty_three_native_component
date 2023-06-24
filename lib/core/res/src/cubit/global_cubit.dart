import 'dart:convert';
import 'dart:io';

import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/local_storage_service.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(AppInitial());

  ///language
  Future<void> loadLanguage(String l) async {
    String translation;
    String errorTranslation;
    final String langFileName = l;
    translation =
        await rootBundle.loadString('assets/localization/$langFileName.json');
    errorTranslation =
        await rootBundle.loadString('assets/errors/$langFileName.json');
    localization = jsonDecode(translation) as Map<String, dynamic>;
    errorLocalization = jsonDecode(errorTranslation) as Map<String, dynamic>;
    await sl<LocalStorageService>().writeKey('lang', l);

    currentUserPermission.locale = l;

    emit(LanguageChanged());
  }

  ///changeLang
  Future<void> changeTextField() async {
    emit(TextFieldChanged());
  }

  void onLoading(){
    emit(GlobalOtpLoading());
  }

  void onLoaded(){
    emit(GlobalOtpLoaded());
  }

  Future<void> validateLanguage(String apiLanguage) async {
    if (apiLanguage != Platform.localeName.split(".").first.split('_').first) {
      await loadLanguage(apiLanguage);
    }
  }
}

bool get isArabic {
  return currentUserPermission.locale == 'ar';
}
