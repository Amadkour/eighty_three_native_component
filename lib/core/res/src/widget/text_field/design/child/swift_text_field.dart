import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../eighty_three_component.dart';
import '../../../../../theme/colors.dart';
import '../../validator/child/cvv_validator.dart';

class CvvTextField extends StatelessWidget {
  const CvvTextField({
    super.key,
    required this.onChanged,
    this.focusNode,
  });

  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      validator: CVVValidator().validation(),
      textInputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      fillColor: AppColors.backgroundColor,
      focusNode: focusNode,
      hint: tr("cvv_number"),
      title: tr('cvv'),
    );
  }
}
