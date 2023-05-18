import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/parent/parent_validator.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:queen_validators/queen_validators.dart';

class IDValidator extends ParentValidator {
  @override
  String? Function(String?)? getValidation() {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage('id_empty'),
        ),
        MinLength(
          8,
          errorMessage("${tr("id_at_least")}8 ${tr("letters")}"),
        ),
        MaxLength(10,  errorMessage("${tr("id_greater")}10 ${tr("letters")}"),)
      ],
    );
  }

  @override
  String? Function(String?)? getValidationWithLength(
      {int? minLength, int? maxLength}) {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage('id_empty'),
        ),
        MinLength(
          minLength ?? 10,
          errorMessage("${tr("id_at_least")}$minLength ${tr("letters")}"),
        ),
        MaxLength(
            maxLength ?? 10,
            errorMessage("${tr("id_greater")}$maxLength ${tr("letters")}"),
        )
      ],
    );
  }
}
