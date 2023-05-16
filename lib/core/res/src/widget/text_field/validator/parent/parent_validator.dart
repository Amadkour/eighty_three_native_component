import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:queen_validators/queen_validators.dart';

abstract class ParentValidator {
  String? Function(String?)? getValidation() {
    return null;
  }

  String? Function(String?)? getValidationWithParameter(String key) {
    return null;
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
          errorMessage('id_at_least',maxLength: minLength ?? 10),
        ),
        MaxLength(maxLength ?? 10, errorMessage('id_greater',maxLength: maxLength ?? 10))
      ],
    );
  }

  String? errorMessage(String key, {int? maxLength}) {
    if (key == 'accept') {
      return null;
    } else {
      return tr(key) + (maxLength!=null ? maxLength.toString():"");
    }
  }
}
