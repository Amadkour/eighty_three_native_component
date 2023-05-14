library eighty_three_component;

import 'package:eighty_three_native_component/core/res/src/cubit/country/country_list_model.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/country/country_util.dart';

import 'package:eighty_three_native_component/core/res/src/cubit/currency/provider/model/currency_list_model.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/currency/provider/repo/currency_repo.dart';
import 'package:eighty_three_native_component/core/res/src/errors/failures.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/utils/currency_util.dart';
import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';



String tr(String key, {bool isError = false}) {
  if (!isError) {
    return (localization[key] ?? key).toString();
  } else {
    return (errorLocalization[key] ?? key).toString();
  }
}

Map<String, dynamic> localization = <String, dynamic>{};
Map<String, dynamic> errorLocalization = <String, dynamic>{};

Future<void> initEightyThreeComponent({String? suffixUrl}) async {
  ///country
  await sl<CurrencyRepository>().getCountries().then((value) {
    value.fold((Failure l) => null, (ParentModel r) {
      appCountries = (r as CountryListModel).countries;
    });
  });
  await sl<CurrencyRepository>().getCurrencies().then((value) {
    value.fold((Failure l) => null, (ParentModel r) {
      appCurrencies = (r as CurrencyListModel).currencies;
    });
  });
}
