// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:res_pay_merchant/core/public_apis/provider/api/currency_base_api.dart';

// class CurrencyJsonApi extends CurrencyBaseApi {
//   @override
//   Future<Map<String, dynamic>> getCountries() async {
//     return Future<Map<String, dynamic>>.delayed(const Duration(seconds: 2), () async {
//       final String json = await rootBundle.loadString('assets/jsons/country.json');

//       return jsonDecode(json) as Map<String, dynamic>;
//     });
//   }

//   @override
//   Future<Map<String, dynamic>> getCurrencies() {
//     return Future<Map<String, dynamic>>.delayed(const Duration(seconds: 2), () async {
//       final String json = await rootBundle.loadString('assets/jsons/country.json');

//       return jsonDecode(json) as Map<String, dynamic>;
//     });
//   }
// }
