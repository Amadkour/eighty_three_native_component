import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/empty_validation.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField(
      {super.key,
      required this.controller,
      required this.title,
      this.onChanged,
      required this.focusNode});

  final TextEditingController controller;
  final String title;
  final void Function(String)? onChanged;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      validator: EmptyValidator().getValidationWithParameter(tr('required')),
      controller: controller,
      hint: tr('input'),
      onChanged: onChanged,
      focusNode: focusNode,
      title: title,
      fillColor: Colors.white,
    );
  }
}
