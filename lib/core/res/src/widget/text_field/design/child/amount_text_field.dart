import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/child/salary_text_field.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountTextField extends StatelessWidget {
  final String? initialText;
  final String? titleText;
  final String? hintText;
  final String? defaultValue;
  final String? titleFontFamily;
  final String? label;
  final double? titleFontSize;
  final int maxLength;
  final FocusNode? focusNode;
  final double? hintFontSize;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final bool readOnly;
  final Color? borderColor;
  final double? borderRadius;
  final bool isLocal;
  final bool autoFocus;
  final void Function(String value)? onChanged;
  final bool withCurrency;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const AmountTextField({
    super.key,
    this.hintText,
    this.defaultValue,
    this.textAlign = TextAlign.start,
    this.label,
    this.hintFontSize,
    this.onChanged,
    this.titleFontSize,
    this.initialText,
    this.suffixIcon,
    this.controller,
    this.autoFocus = false,
    this.readOnly = false,
    this.isLocal = false,
    this.withCurrency = true,
    this.titleText,
    this.inputFormatters,
    this.keyboardType,
    this.borderColor,
    this.borderRadius,
    this.titleFontFamily,
    this.focusNode,
    required this.maxLength,
  });

  factory AmountTextField.salaryAmount({
    Key? key,
    Color? borderColor,
    String hintText = "500",
    double? hintFontSize,
    double? borderRadius,
    int? maxLength,
    double? titleFontSize,
    String? initialText,
    String? titleText,
    String? titleFontFamily,
    FocusNode? focusNode,
    Widget? suffixIcon,
    void Function(String value)? onChanged,
    TextEditingController? controller,
    bool readOnly = false,
    bool hasValidation = true,
    Color? color,
    String? defaultValue,
    bool isRequired = true,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    final SalaryTextField image = SalaryTextField(
      hasValidationMessage: hasValidation,
      key: key,
      maxLength: maxLength,
      focusNode: focusNode,
      titleFontFamily:titleFontFamily,
      borderColor: borderColor,
      borderRadius: borderRadius,
      color: color,
      suffixIcon: suffixIcon,
      hintFontSize: hintFontSize,
      hintText: hintText,
      titleText: titleText,
      titleFontSize: titleFontSize,
      isRequired: isRequired,
      inputFormatters: inputFormatters,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: (String v) {
        ///formatter
        if (v.isNotEmpty && v[0] == '0') {
          controller?.text = '';
        }
        controller?.text = controller.text.amountFormatter;

        ///action callback
        controller?.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));

        if (onChanged != null) {
          onChanged.call(v);
        } else {
          // sl<TransactionAmountCubit>().onAmountChange.call(v);
        }
      },
      controller: controller,
      initialText: initialText,
      readOnly: readOnly,
    );
    child = image;
    return image;
  }

  static late Widget child;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
