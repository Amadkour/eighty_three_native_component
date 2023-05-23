import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/money_amount_validator.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SavingRoleTextField extends StatelessWidget {
  const SavingRoleTextField(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.focusNode});
  final TextEditingController controller;
  final void Function(String? value) onChanged;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      validator: MoneyAmountValidator().getValidation(),
      keyboardType: TextInputType.number,
      focusNode: focusNode,
      textInputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        LengthLimitingTextInputFormatter(6)
      ],

      controller: controller,
      emitTextFieldChange: false,
      onChanged: (String? value) {
        onChanged.call(value);
      },
      hint: tr('amount'),
      style: const TextStyle(fontWeight: FontWeight.bold),
      fillColor: AppColors.backgroundColor,
    );
  }
}
