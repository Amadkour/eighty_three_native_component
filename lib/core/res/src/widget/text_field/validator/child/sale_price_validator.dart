import 'package:queen_validators/queen_validators.dart';

import '../parent/parent_validator.dart';

class SalePriceValidator extends ParentValidator {
  @override
  String? Function(String? p1)? getValidation({String? price}) {
    return qValidator([
      SalePriceRule(price: price),
    ]);
  }
}

class SalePriceRule extends TextValidationRule {
  String? price;
  SalePriceRule({this.price}) : super("");

  @override
  bool isValid(String input) {
    if (input.isNotEmpty) {
      return (double.tryParse(input) ?? 0) <=
          (double.tryParse(price ?? "0") ?? 0);
    } else
      return true;
  }
}
