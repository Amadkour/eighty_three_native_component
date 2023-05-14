import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/child/account_num_text_field.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/expire_date_validator.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpireDateTextField extends StatelessWidget {
  const ExpireDateTextField({
    super.key,
    required this.onChanged,
    required this.controller,
    this.date,
    required this.focusNode,
    this.haveTitle = true,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
  });

  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String? date;
  final Color? fillColor;
  final Color? borderColor;
  final bool haveTitle;
  final double? borderRadius;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      controller: controller,
      readOnly: true,
      focusNode: focusNode,
      borderColor: borderColor,
      borderRadius: borderRadius,
      title: haveTitle ? tr("valid_until") : null,
      fillColor: fillColor ?? AppColors.backgroundColor,
      keyboardType: TextInputType.number,
      textInputFormatter: <TextInputFormatter>[
        MaskedTextInputFormatter(
          mask: "##/####",
          separator: "/",
        ),
        FilteringTextInputFormatter.allow(RegExp(r'^\d+(\/\d+)*$'))
      ],
      onChanged: onChanged,
      validator: ExpireDateValidator().validation(),
      hint: "MM/YY",
    );
  }
}
