import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/empty_validation.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';

class SwiftCodeTextField extends StatelessWidget {
  final TextEditingController? nameController;
  final String? nameControllerError;
  final String? textInputType;
  final String? title;
  final String hint;
  final int? minLength;
  final int? multiLine;
  final String? errorMessage;
  final String? minErrorMessage;
  final bool? readOnly;
  final InputBorder? border;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final Color? color;
  const SwiftCodeTextField({
    super.key,
    this.border,
    this.textInputType,
    this.errorMessage,
    this.multiLine,
    this.minErrorMessage,
    this.readOnly,
    this.minLength,
    this.nameController,
    this.focusNode,
    this.nameControllerError,
    required this.hint,
    this.title,
    this.onChanged,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    String? error = nameControllerError;

    return ParentTextField(
      multiLine: multiLine ?? 1,
      controller: nameController,
      keyboardType: TextInputType.phone,
      name: tr(hint),
      hint: tr(hint),
      readOnly: readOnly ?? false,
      validator:
          EmptyValidator(minLength: minLength, minErrorMessage: minErrorMessage)
              .getValidationWithParameter(errorMessage ?? "name_empty"),
      focusNode: focusNode,
      title: title != null ? tr(title!) : null,
      onChanged: (String? v) {
        error = '';
        onChanged?.call(v!);
      },
      error: error,
      border: border,
      fillColor: color ?? Colors.white,
    );
  }
}
