import 'package:eighty_three_native_component/core/res/src/provider/api/api_connection.dart';

String get getCurrencyEndPoint =>
    "/${BaseUrlModules.authentication.name}/currencies/list";
String get getCountryEndPoint =>
    "/${BaseUrlModules.authentication.name}/countries/list";
String get getCitiesEndPoint =>
    "/${BaseUrlModules.authentication.name}/cities/get-country-cities";
