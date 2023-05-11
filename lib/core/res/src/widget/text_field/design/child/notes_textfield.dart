import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class NotesTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool isRequired;
  final TextEditingController? noteController;
  const NotesTextField({
    super.key,
    this.noteController,
    required this.onChanged,
    this.color,
    this.focusNode,
    this.isRequired = true,
    this.readOnly = false,
    this.hint,
    this.hasTitle = true,
    this.defaultValue,
  });
  final Color? color;
  final String? hint;
  final bool readOnly;
  final FocusNode? focusNode;
  final String? defaultValue;
  final bool hasTitle;
  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      multiLine: 4,
      validator: (String? c) {
        if (isRequired) {
          if (c!.isEmpty) {
            return tr("required");
          } else {
            return null;
          }
        } else {
          return null;
        }
      },
      focusNode: focusNode,
      defaultValue: defaultValue,
      controller: noteController,
      readOnly: readOnly,
      onChanged: onChanged,
      keyboardType: TextInputType.name,
      hint: hint,
      name: hasTitle ? tr("notes") : null,
      title: hasTitle ? tr("notes") : null,
      fillColor: color ?? AppColors.backgroundColor,
    );
  }
}
