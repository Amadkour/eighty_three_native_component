import 'package:eighty_three_native_component/core/res/src/constant/widget_keys.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/money_amount_validator.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/res/theme/font_styles.dart';
import 'package:eighty_three_native_component/core/shared/amount/controller/transaction_amount_cubit.dart';
import 'package:eighty_three_native_component/core/shared/transfer/view/component/currency_drop_down_widget.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'salary_text_field.dart';
part 'transfer_amount_textfield.dart';

class AmountTextField extends StatelessWidget {
  final String? initialText;
  final String? titleText;
  final String? hintText;
  final String? defaultValue;
  final String? label;
  final double? titleFontSize;
  final double? hintFontSize;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final bool readOnly;
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
  });

  factory AmountTextField.salaryAmount({
    Key? key,
    String hintText = "500",
    double? hintFontSize,
    double? titleFontSize,
    String? initialText,
    String? titleText,
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
    final _SalaryTextField image = _SalaryTextField(
      hasValidationMessage: hasValidation,
      key: key,
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
          sl<TransactionAmountCubit>().onAmountChange.call(v);
        }
      },
      controller: controller,
      initialText: initialText,
      readOnly: readOnly,
    );
    child = image;
    return image;
  }

  factory AmountTextField.transferAmount({
    Key? key,
    void Function(String value)? onChanged,
    String? label,
    String? defaultValue,
    TextAlign textAlign = TextAlign.start,
    TextEditingController? controller,
    bool readOnly = false,
    bool withCurrency = true,
    bool autoFocus = false,
    bool isLocal = false,
  }) {
    final _TransactionAmountTextField image = _TransactionAmountTextField(
      key: key,
      controller: controller,
      defaultValue: defaultValue,
      isLocal: isLocal,
      label: label,
      onChanged: (String v) {
        ///formatter
        if (v.isNotEmpty && v[0] == '0') {
          controller!.text = '';
        }
        controller!.text = controller.text.amountFormatter;

        ///action callback
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
        if (onChanged != null) {
          onChanged.call(v);
        } else {
          sl<TransactionAmountCubit>().onAmountChange.call(v);
        }
      },
      withCurrency: withCurrency,
      textAlign: textAlign,
      autoFocus: autoFocus,
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
