import 'package:auto_size_text/auto_size_text.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/material.dart';

class LeadingTrailingListWidget extends StatelessWidget {
  final String? leadingText;
  final String? trailingText;
  final Color? leadingColor;
  final Color? trailingColor;
  final bool? isDivider;

  const LeadingTrailingListWidget(
      {super.key, required this.leadingText,
      required this.trailingText,
      this.leadingColor,
      this.isDivider = false,
      this.trailingColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AutoSizeText(
              leadingText!,
              style: TextStyle(
                color: leadingColor ?? AppColors.blackColor,
              ),
            ),
            AutoSizeText(
              trailingText!,
              style: TextStyle(
                  color: trailingColor ?? AppColors.blackColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (isDivider!)
          Divider(
            thickness: 1,
            color: AppColors.borderColor,
          )
      ],
    );
  }
}
