import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountNumText extends StatelessWidget {
  final TextEditingController? accountNumber;
  final String? accountNumberError;
  final FocusNode? focusNode;
  final bool haveTitle;
  final double? borderRadius;
  final String? title;
  final String? titleFontFamily;
  final String? hint;
  final Color? borderColor;
  final bool readOnly;
  final double? titleFontSize;
  final void Function(String)? onChanged;

  const AccountNumText({
    super.key,
    this.titleFontSize,
    this.accountNumber,
    this.focusNode,
    this.onChanged,
    this.accountNumberError,
    this.titleFontFamily,
    this.title,
    this.borderColor,
    this.haveTitle = true,
    this.borderRadius,
    this.hint,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    String? error = accountNumberError;
    return ParentTextField(
      titleFontFamily: titleFontFamily,
      onChanged: (String val) {
        if (onChanged != null) {
          onChanged!(val);
        } else {
          error = '';
        }
      },
      borderColor: borderColor,
      textInputFormatter: <TextInputFormatter>[
        MaskedTextInputFormatter(
          mask: '****-****-****-****-****-****-****-****-****-****',
          separator: '-',
        ),
        FilteringTextInputFormatter.allow(RegExp('[0-9]|-'))
      ],
      maxLength: 49,
      borderRadius: borderRadius,
      controller: accountNumber,
      titleFontSize: titleFontSize,
      keyboardType: TextInputType.number,
      hint: hint ?? "0000-0000-0000-0000-0000-00000",
      validator: (value) {
        if(value!=null){
          String correctValue="";
          if(!value.contains("*****")){
            correctValue = value.removeNonNumber;
          }
          else{
            correctValue = value;
          }
          if(correctValue.isEmpty){
            return tr("account_number_empty");
          }
          else if(correctValue.length<7){
            return tr("account_number_lower");
          }
        }
        return null;
      },
      title: haveTitle ? title ?? tr("Account Number") : null,
      focusNode: focusNode,
      readOnly: readOnly,
      error: error,
    );
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String? mask;
  final String? separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask!.length) return oldValue;
        if (newValue.text.length < mask!.length &&
            mask![newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
