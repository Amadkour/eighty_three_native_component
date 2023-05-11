import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/parent/parent_validator.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:queen_validators/queen_validators.dart';

class RequiredValidation extends ParentValidator {
  @override
  String? Function(String? p1)? getValidationWithLength(
      {int? minLength, int? maxLength}) {
    return qValidator(<TextValidationRule>[
      if (maxLength != null)
        MaxLength(
          maxLength,
          errorMessage("must not be greater than $maxLength characters."),
        ),
      if (minLength != null)
        MinLength(minLength,
            errorMessage("${tr("at least")} $minLength ${tr("characters")}")),
    ]);
  }
}
