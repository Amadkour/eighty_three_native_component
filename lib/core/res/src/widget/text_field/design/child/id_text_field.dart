import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/id_validator.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class IDTextField extends StatelessWidget {
  final TextEditingController? idController;
  final FocusNode? idFocusNode;
  final String? idTitle;
  final String? idHint;
  final bool? readOnly;
  final String? error;
  final double? fullWidth;
  final double? titleFontSize;
  final Color? fillColor;
  final void Function()? onTab;
  final void Function(String)? onChanged;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLength;
  final int? minLength;
  const IDTextField({
    super.key,
    this.idController,
    this.idFocusNode,
    this.idTitle = '',
    this.readOnly,
    this.idHint = '',
    this.onTab,
    this.fillColor,
    this.error,
    this.fullWidth,
    this.titleFontSize,
    required this.onChanged,
    this.prefix,
    this.suffix,
    this.maxLength = 10,
    this.minLength = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      prefix: prefix,
      suffix: suffix,
      controller: idController,
      error: error,
      onChanged: (String? value) {
        onChanged!.call(value!);
      },
      onTab: onTab,
      readOnly: readOnly ?? false,
      titleFontSize: titleFontSize,
      fillColor: fillColor ?? Colors.white,
      validator: IDValidator()
          .getValidationWithLength(maxLength: maxLength, minLength: minLength),
      keyboardType: TextInputType.number,
      title: tr(idTitle!),
      hint: tr(idHint!),
      hintFontSize: fullWidth == null ? null : fullWidth! / 30,
      focusNode: idFocusNode,
    );
  }
}
