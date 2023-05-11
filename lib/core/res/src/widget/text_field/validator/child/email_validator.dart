import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/parent/parent_validator.dart';
import 'package:queen_validators/queen_validators.dart';

class EmailValidator extends ParentValidator {
  @override
  String? Function(String?)? getValidation() {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage('email_empty'),
        ),
        IsEmail(errorMessage('email_greater'))
      ],
    );
  }
}
