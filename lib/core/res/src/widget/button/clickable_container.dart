import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/res/theme/decoration_values.dart';
import 'package:eighty_three_native_component/core/res/theme/font_styles.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class ClickableContainer extends StatelessWidget {
  const ClickableContainer({
    super.key,
    this.onPressed,
    required this.title,
    required this.value,
    this.color,
    this.trailing,
    this.leading,
  });

  final VoidCallback? onPressed;
  final String title;
  final String value;
  final Color? color;
  final Widget? trailing;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ///title
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            tr(title),
            style: descriptionStyle.copyWith(
              color: Colors.black,
            ),
          ),
        ),

        ///body
        InkWell(
          onTap: onPressed,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: color ?? AppColors.backgroundColor,
              borderRadius: defaultBorderRadius,
            ),
            child: ListTile(
              leading: leading,
              title: Text(
                value,
                style: smallStyle,
              ),
              trailing: trailing ??
                  MyImage.svgAssets(
                    url: "assets/icons/transfer/dropdownarrow.svg",
                    height: 8,
                    width: 8,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
