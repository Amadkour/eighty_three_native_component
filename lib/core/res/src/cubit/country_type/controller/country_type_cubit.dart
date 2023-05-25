import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../provider/model/country_type.dart';
import '../provider/repo/country_type_repository.dart';
part 'country_type_state.dart';

List<CountryType> countryTypes = <CountryType>[];

class CountryTypeCubit extends Cubit<CountryTypeState> {
  CountryTypeCubit() : super(CountryTypeInitial());

  /// -------------------------------- Initialization -------------------------------- ///

  CountryType? selectedCountry;

  List<CountryType> displayedList = <CountryType>[];

  /// Call when opening the page
  Future<void> init({String? suffixUrl}) async {
    final result = await CountryTypeRepository.instance
        .getCountryType(suffixUrl: suffixUrl);
    result.fold((l) => null, (r) {
      countryTypes = (r as CountryTypeList).countries;
      selectedCountry = countryTypes[0];
      displayedList.addAll(countryTypes);
      emit(CountryTypeLoaded());
    });
  }

  /// Change Country in the phone number TextField
  void changeSelectedCountryByCountry(CountryType countryType) {
    selectedCountry = countryType;

    emit(CountryTypeChangeSelectedCountry());
  }
  /// Change Country in the phone number TextField
  void changeSelectedCountry(int index) {
    selectedCountry = countryTypes[index];

    emit(CountryTypeChangeSelectedCountry());
  }

  void search(String query) {
    if (query.isNotEmpty) {
      displayedList.clear();
      displayedList.addAll(countryTypes
          .where((element) =>
              element.title!.toLowerCase().startsWith(query.toLowerCase()))
          .toList());
    } else {
      displayedList
        ..clear()
        ..addAll(countryTypes);
    }
    emit(CountrySearch());
  }
}
