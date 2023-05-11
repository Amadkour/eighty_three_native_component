part of 'amount_text_field.dart';

class _SalaryTextField extends AmountTextField {
  final bool hasValidationMessage;
  final Color? color;
  final bool isRequired;
  final String? Function(String?)? validator;
  const _SalaryTextField({
    super.key,
    String hintText = "500",
    double? hintFontSize,
    double? titleFontSize,
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
            controller: controller,
            hintFontSize: hintFontSize,
            hintText: hintText,
            titleFontSize: titleFontSize,
            initialText: initialText,
            suffixIcon: suffixIcon,
            readOnly: readOnly,
            titleText: titleText,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType);

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      fillColor: color,
      defaultValue: initialText,
      controller: controller,
      key: salaryTextFieldKey,
      readOnly: readOnly,
      title: titleText,
      hintFontSize: hintFontSize,
      titleFontSize: titleFontSize,
      textInputFormatter: inputFormatters ??
          <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            LengthLimitingTextInputFormatter(6)
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
