import 'package:auto_size_text/auto_size_text.dart';
import 'package:eighty_three_native_component/core/res/src/constant/widget_keys.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/material.dart';

class RowTitleWidget extends StatelessWidget {
  final String blackText;
  final String blueText;
  final VoidCallback? onTapBlueText;
  final bool showBlueText;

  const RowTitleWidget({
    super.key,
    required this.blackText,
    required this.blueText,
    this.onTapBlueText,
    this.showBlueText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AutoSizeText(
          blackText,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        if (showBlueText)
          InkWell(
            key: blueTextKey,
            onTap: onTapBlueText,
            child: Row(
              children: <Widget>[
                AutoSizeText(
                  blueText,
                  style:
                      TextStyle(color: AppColors.blueTextColor, fontSize: 12),
                ),
                RotatedBox(
                    quarterTurns: 2,
                    child: Icon(Icons.arrow_back_ios,
                        size: 10, color: AppColors.blueTextColor))
              ],
            ),
          )
      ],
    );
  }
}
