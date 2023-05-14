import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/credit_card_validator.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'account_num_text_field.dart';

class CreditCardNumberTextField extends StatelessWidget {
  const CreditCardNumberTextField({
    super.key,
    required this.onChanged,
    this.focusNode,
  });
  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      validator: CreditCardValidator().validation(),
      fillColor: AppColors.backgroundColor,
      focusNode: focusNode,
      textInputFormatter: <TextInputFormatter>[
        MaskedTextInputFormatter(
          mask: "****-****-****-****",
          separator: "-",
        ),
        FilteringTextInputFormatter.allow(RegExp('[0-9]|-'))
      ],
      hint: tr("card_number"),
      title: tr('card_number'),
    );
  }
}
