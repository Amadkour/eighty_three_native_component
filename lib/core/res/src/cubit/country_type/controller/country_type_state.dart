part of 'country_type_cubit.dart';

@immutable
abstract class CountryTypeState {}

class CountryTypeInitial extends CountryTypeState {}

class CountryTypeLoaded extends CountryTypeState {}

class CountryTypeChangeSelectedCountry extends CountryTypeState {}

class CountrySearch extends CountryTypeState {}
