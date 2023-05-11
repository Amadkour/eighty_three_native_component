import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/description_validation.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    super.key,
    this.onChanged,
    this.hint,
    this.color, this.controller,
  });
  final ValueChanged<String>? onChanged;
  final String? hint;
  final Color? color;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      validator: DescriptionValidation().getValidation(),
      onChanged: onChanged,
      title: hint == null ? tr('description') : null,
      hint: hint,
      multiLine: 5,
      controller: controller,
      fillColor: color,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: context.theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
