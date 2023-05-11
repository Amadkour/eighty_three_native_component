import 'country.dart';

List<Country> appCountries = [];
Country getCountry({required int uuid}) {
  return appCountries.firstWhere((Country element) => element.id == uuid);
}
