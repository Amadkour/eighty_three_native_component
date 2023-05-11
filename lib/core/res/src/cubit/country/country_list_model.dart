import 'package:eighty_three_native_component/core/res/src/cubit/country/country.dart';
import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';

class CountryListModel extends ParentModel {
  final List<Country> countries;

  CountryListModel({this.countries = const <Country>[]});
  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> countries =
        List<Map<String, dynamic>>.from(json['countries'] as List<dynamic>);

    return CountryListModel(
        countries: List<Country>.from(
            countries.map((Map<String, dynamic> e) => Country.fromMap(e))));
  }
}
