import 'package:eighty_three_native_component/core/res/src/cubit/currency/provider/model/currency.dart';

List<Currency> appCurrencies = [];
Currency getCurrency(int id) {
  return appCurrencies.firstWhere((Currency element) => element.id == id);
}
