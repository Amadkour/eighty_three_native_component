import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/parent/parent_validator.dart';
import 'package:queen_validators/queen_validators.dart';

class IbanValidator extends ParentValidator {
  String? Function(String?)? validation() {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage('IBAN_empty'),
        ),
        MaxLength(
          40,
          errorMessage('IBAN_greater', maxLength: 40),
        ),
        MinLength(
          6,
          errorMessage('IBAN_lower', maxLength: 6),
        ),
      ],
    );
  }
}
