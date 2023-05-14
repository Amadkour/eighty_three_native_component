import 'package:auto_size_text/auto_size_text.dart';
import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';

import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/res/theme/decoration_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'images/my_image.dart';

class ItemInDropDown extends StatelessWidget {
  const ItemInDropDown(
      {super.key,
      required this.itemText,
      this.itemImageUrl,
      this.defaultSvgImage = "assets/flags/saudi_arabia.svg",
      this.haveImage = false});

  final String itemText;
  final String? itemImageUrl;
  final String? defaultSvgImage;
  final bool haveImage;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.lightWhite, borderRadius: defaultBorderRadius),
        alignment: currentUserPermission.isArabic
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(3),
        child: Row(
          textDirection:
              !currentUserPermission.isArabic ? TextDirection.ltr : TextDirection.rtl,
          children: <Widget>[
            if (haveImage)
              Padding(
                padding: EdgeInsets.only(
                    right: !currentUserPermission.isArabic ? 7 : 0,
                    left: !currentUserPermission.isArabic ? 0 : 7),
                child: ClipOval(
                  child: itemImageUrl != null
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: SvgPicture.network(
                              itemImageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : MyImage.svgAssets(
                          url: defaultSvgImage,
                          height: 22,
                          width: 20,
                        ),
                ),
              )
            else
              const SizedBox.shrink(),
            Expanded(
                child: AutoSizeText(itemText,
                    overflow: TextOverflow.ellipsis,
                    textDirection: !currentUserPermission.isArabic
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ))),
          ],
        ));
  }
}
