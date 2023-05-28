
import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/child/amount_text_field.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/money_amount_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SalaryTextField extends AmountTextField {
  final bool hasValidationMessage;
  final Color? color;

  final bool isRequired;
  final String? Function(String?)? validator;
  const SalaryTextField({
    super.key,
    String hintText = "500",
    double? hintFontSize,
    double? titleFontSize,
    String? titleFontFamily,
    Color? borderColor,
    double? borderRadius,
    int? maxLength,
    FocusNode? focusNode,
    String? initialText,
    Widget? suffixIcon,
    void Function(String value)? onChanged,
    TextEditingController? controller,
    bool readOnly = false,
    String? titleText,
    this.hasValidationMessage = true,
    this.color,
    this.isRequired = true,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    this.validator,
  }) : super(
            onChanged: onChanged,
            focusNode: focusNode,
            maxLength: maxLength??6,
            controller: controller,
            borderRadius: borderRadius,
            borderColor: borderColor,
            hintFontSize: hintFontSize,
            hintText: hintText,
            titleFontSize: titleFontSize,
            initialText: initialText,
            suffixIcon: suffixIcon,
            titleFontFamily: titleFontFamily,
            readOnly: readOnly,
            titleText: titleText,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType);

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      fillColor: color,
      borderColor: borderColor,
      borderRadius: borderRadius,
      titleFontFamily: titleFontFamily,
      defaultValue: initialText,
      controller: controller,
      key: const Key('salary_text_field'),
      readOnly: readOnly,
      focusNode: focusNode,
      title: titleText,
      hintFontSize: hintFontSize,
      titleFontSize: titleFontSize,
      textInputFormatter: inputFormatters ??
          <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            LengthLimitingTextInputFormatter(maxLength)
          ],
      onChanged: onChanged,
      hint: hintText ?? "500",
      suffix: suffixIcon,
      emitTextFieldChange: false,
      validator: hasValidationMessage
          ? MoneyAmountValidator().getValidation()
          : validator ??
              (!isRequired
                  ? null
                  : (value) {
                      ///Hide Error message in some case
                      String? Function(String?)? onValidate =
                          MoneyAmountValidator().getValidation();
                      final validationMessage = onValidate?.call(value);
                      if (validationMessage != null) {
                        return '';
                      } else {
                        return null;
                      }
                    }),
      keyboardType: keyboardType ?? TextInputType.number,
    );
  }
}
