import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/parent/parent_validator.dart';
import 'package:queen_validators/queen_validators.dart';

class ExpireDateValidator extends ParentValidator {
  String? Function(String? p1)? validation() {
    return qValidator(
      <TextValidationRule>[IsRequired(''), MaxLength(7, ''), MinLength(7, '')],
    );
  }
}
