import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/parent/parent_validator.dart';
import 'package:queen_validators/queen_validators.dart';

class DescriptionValidation extends ParentValidator {
  @override
  String? Function(String? value)? getValidation() {
    return qValidator(<TextValidationRule>[
      IsRequired(errorMessage("empty_description")),
    ]);
  }
}
