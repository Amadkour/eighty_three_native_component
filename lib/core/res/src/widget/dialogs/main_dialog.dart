import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eighty_three_native_component/core/res/src/constant/shared_orefrences_keys.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/global_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';

class MainDialog {
  final String? imagePNG;
  final double? imageHeight;
  final double? imageWidth;
  final String? dialogTitle;
  final String? dialogSupTitle;
  final String? endTitle;
  final Widget? icon;
  final Widget? bottomWidget;
  void Function()? onPressedText;

  MainDialog({
    this.imagePNG,
    this.dialogTitle,
    this.dialogSupTitle,
    this.endTitle,
    this.imageHeight,
    this.imageWidth,
    this.icon,
    this.bottomWidget,
    this.onPressedText,
  }) {
    showDialog(
        context: globalKey.currentContext!,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              width: context.width * 0.95,
              height: context.height * 0.58,
              child: Padding(
                padding: const EdgeInsets.only(left: 23, right: 23),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (imagePNG != null)
                      MyImage.assets(
                        url: imagePNG!,
                        height: imageHeight!,
                        width: imageWidth!,
                      ),
                    if (imagePNG == null) icon!,
                    const SizedBox(
                      height: 24,
                    ),
                    AutoSizeText(
                      tr(dialogTitle!),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'semiBold',
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      key: const Key("go_back_key"),
                      onTap: onPressedText,
                      child: AutoSizeText(
                        tr(dialogSupTitle!),
                        textDirection:
                            isArabic ? TextDirection.rtl : TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Plain',
                          color: AppColors.blackColor.withOpacity(.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    bottomWidget ?? const SizedBox()
                  ],
                ),
              ),
            ),
          );
        });
  }
}
