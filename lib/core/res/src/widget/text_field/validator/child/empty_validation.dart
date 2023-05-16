import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/parent/parent_validator.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:queen_validators/queen_validators.dart';

class EmptyValidator extends ParentValidator {
  final int? minLength;
  final int? maxLength;
  final String? minErrorMessage;
  EmptyValidator({this.maxLength, this.minLength, this.minErrorMessage});
  @override
  String? Function(String?)? getValidationWithParameter(String key) {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage(key),
        ),
        if(maxLength!=null)...[
          MaxLength(
              maxLength ?? 10,
              errorMessage(minErrorMessage ?? "${tr("name_greater")}${maxLength ?? 10} ${tr("letters")}"),
          ),
        ],
        if (minLength != null) ...<TextValidationRule>[
          MinLength(
            minLength ?? 4,
            errorMessage(minErrorMessage ?? "${tr("at_least")}${minLength ?? 4} ${tr("letters")}"),
          ),
        ]
      ],
    );
  }
}
