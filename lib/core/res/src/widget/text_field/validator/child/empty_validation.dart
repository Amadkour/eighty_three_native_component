import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/parent/parent_validator.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:queen_validators/queen_validators.dart';

class EmptyValidator extends ParentValidator {
  final int? minLength;
  final String? minErrorMessage;
  EmptyValidator({this.minLength, this.minErrorMessage});
  @override
  String? Function(String?)? getValidationWithParameter(String key) {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage(key),
        ),
        if (minLength != null) ...<TextValidationRule>[
          MinLength(
            minLength!,
            errorMessage(minErrorMessage ??
                "${tr("at least")} $minLength ${tr("letters")}"),
          ),
        ]
      ],
    );
  }
}
