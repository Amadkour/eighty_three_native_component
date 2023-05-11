import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/parent/parent_validator.dart';
import 'package:queen_validators/queen_validators.dart';

class AccountNumberValidator extends ParentValidator {
  String? Function(String? p1)? validation() {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage('account_number_empty'),
        ),
        MinLength(
          7,
          errorMessage('account_number_lower'),
        ),
        MaxLength(
          49,
          errorMessage('account_number_greater'),
        ),
      ],
    );
  }
}
