import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/iban_validator.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class IbanText extends StatelessWidget {
  final TextEditingController? iBANController;
  final String? iBANError;
  final FocusNode? focusNode;
  final double? titleFontSize;
  final void Function(String)? onChanged;
  const IbanText({
    super.key,
    this.onChanged,
    this.titleFontSize,
    this.iBANController,
    this.focusNode,
    this.iBANError,
  });

  @override
  Widget build(BuildContext context) {
    String? error = iBANError;

    return ParentTextField(
      onChanged: (String val) {
        if (onChanged != null) {
          onChanged!(val);
        } else {
          error = '';
        }
      },
      maxLength: 40,
      titleFontSize: titleFontSize,
      controller: iBANController,
      keyboardType: TextInputType.text,
      hint: "XXXXXXXXXXXXX",
      validator: IbanValidator().validation(),
      title: tr("IBAN"),
      focusNode: focusNode,
      error: error,
    );
  }
}
