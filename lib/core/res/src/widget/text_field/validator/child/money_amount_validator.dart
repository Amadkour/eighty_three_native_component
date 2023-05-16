import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/parent/parent_validator.dart';
import 'package:queen_validators/queen_validators.dart';

class MoneyAmountValidator extends ParentValidator {
  @override
  String? Function(String?)? getValidation() {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage('required_amount'),
        ),
        NotZeroValidationRule(
          errorMessage: errorMessage("zero_amount_error"),
        ),
      ],
    );
  }
}

class NotZeroValidationRule extends TextValidationRule {
  const NotZeroValidationRule({String? errorMessage}) : super((errorMessage));

  @override
  bool isValid(String input) {
    return double.tryParse(input) != 0;
  }
}
