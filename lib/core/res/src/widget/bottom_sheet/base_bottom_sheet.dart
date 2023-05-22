import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';

import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/button/loading_button.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/res/theme/font_styles.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';

void showCustomBottomSheet({
  required BuildContext context,
  required Widget body,
  VoidCallback? onPressed,
  VoidCallback? onCanceled,
  required String title,
  String? blackButtonTitle,
  String? whiteButtonText,
  Color? whiteButtonTextColor,
  bool isTwoButtons = true,
  bool hasButtons = true,
  Color? color,
  double? whiteButtonFontSize,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,

  /// Auto close sheet when confirm button tapped ?
  bool autoClose = true,
  bool isScrollable = false,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: currentUserPermission.isArabic
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
          constraints: BoxConstraints(maxHeight: context.height * 0.9),
          // margin: margin ?? const EdgeInsets.only(top: 60),
          padding: padding ??
              const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 25,
              ),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: padding == null ? 0 : 25,
              ),
              Center(
                child: MyImage.svgAssets(
                  url: 'assets/images/moreBottomsheet/Rectangle.svg',
                  width: 64,
                  height: 5,
                ),
              ),
              title != ""
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: 30,
                        left: padding == null ? 0 : 20,
                        right: padding == null ? 0 : 20,
                      ),
                      child: Text(
                        tr(title),
                        style: paragraphStyle.copyWith(
                          color: AppColors.blackColor,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : const SizedBox(),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      body,
                      if (hasButtons) ...<Widget>[
                        LoadingButton(
                          hasBottomSaveArea: false,
                          key: const Key("history_period_apply_button"),
                          isLoading: false,
                          title: blackButtonTitle ?? tr('apply'),
                          onTap: () {
                            onPressed?.call();
                            if (autoClose) {
                              CustomNavigator.instance.pop();
                            }
                          },
                        ),
                        if (isTwoButtons)
                          Center(
                            child: TextButton(
                              key: const Key("history_period_cancel_button"),
                              onPressed: () {
                                CustomNavigator.instance.pop();
                                onCanceled?.call();
                              },
                              child: Text(
                                whiteButtonText ?? tr('cancel'),
                                style: buttonsStyle.copyWith(
                                  fontSize: whiteButtonFontSize,
                                  color: whiteButtonTextColor ?? Colors.black,
                                ),
                              ),
                            ),
                          )
                      ],
                    ],
                  ),
                ),
              ),
               SizedBox(
                height:MediaQuery.of(context).viewInsets.bottom+ 10,
              )
            ],
          ),
        ),
      );
    },
  );
}
