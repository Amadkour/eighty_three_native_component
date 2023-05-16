import 'package:eighty_three_native_component/core/utils/parsing/from_map.dart';
import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';

class CountryType extends ParentModel {
  CountryType({
    int? countryTypeId,
    String? countryTypeCode,
    String? countryTypeTitle,
    String? countryPhoneCode,
    String? countryTypeIcon,
    int? idMax,
  }) {
    id = countryTypeId;
    code = countryTypeCode;
    title = countryTypeTitle;
    phoneCode = countryPhoneCode;
    icon = countryTypeIcon;
    idLimit = idMax;
  }

  late int? id;
  late String? code;
  late String? title;
  late String? phoneCode;
  late String? icon;
  int? idLimit;

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);

    return CountryType(
      countryTypeId: converter.convertToInt(key: 'id'),
      countryTypeCode: converter.convertToString(key: 'code'),
      countryTypeTitle: converter.convertToString(key: 'name'),
      countryPhoneCode: converter.convertToString(key: 'phone_code'),
      countryTypeIcon: converter.convertToString(key: 'flag'),
      idMax: converter.convertToInt(key: 'id_limit') ?? 3,
    );
  }
}

class CountryTypeList extends ParentModel {
  final List<CountryType> countries;

  CountryTypeList({this.countries = const []});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    final countries = converter.convertToListOFModel<CountryType>(
      modelInstance: CountryType(),
      jsonData: json['countries'],
    );
    return CountryTypeList(
      countries: countries,
    );
  }
}