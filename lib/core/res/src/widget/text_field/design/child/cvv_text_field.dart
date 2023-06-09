import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/cvv_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
class CvvTextField extends StatelessWidget {
  const CvvTextField({
    super.key,
    required this.onChanged,
    this.focusNode,
    this.fillColor,
    this.borderColor,
    this.readOnly=false,
    this.haveTitle=true,
    this.borderRadius,
    this.cvvController,
  });

  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;
  final TextEditingController? cvvController;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final bool haveTitle;
  final bool readOnly;


  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      controller: cvvController,
      keyboardType: TextInputType.number,
      readOnly: readOnly,
      onChanged: onChanged,
      validator: CVVValidator().validation(),
      textInputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      focusNode: focusNode,
      hint: tr("cvv_number"),
      borderColor: borderColor,
      borderRadius: borderRadius,
      title: haveTitle ? tr("cvv") : null,
      fillColor: fillColor ?? AppColors.backgroundColor,
    );
  }
}
