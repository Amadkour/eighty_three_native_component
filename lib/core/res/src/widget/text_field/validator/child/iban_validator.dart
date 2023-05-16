import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/parent/parent_validator.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
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
          errorMessage("${tr("IBAN_greater")}40 ${tr("letters")}"),
        ),
        MinLength(
          6,
          errorMessage("${tr("IBAN_lower")}6 ${tr("letters")}"),
        ),
      ],
    );
  }
}
