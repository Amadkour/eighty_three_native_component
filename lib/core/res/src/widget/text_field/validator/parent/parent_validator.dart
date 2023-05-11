import 'package:eighty_three_native_component/eighty_three_native_component.dart';

abstract class ParentValidator {
  String? Function(String?)? getValidation() {
    return null;
  }

  String? Function(String?)? getValidationWithParameter(String key) {
    return null;
  }

  String? Function(String?)? getValidationWithLength(
      {int? minLength, int? maxLength}) {
    return null;
  }

  String? errorMessage(String key, {String? maxLength}) {
    if (key == 'accept') {
      return null;
    } else {
      return tr(key);
    }
  }
}
