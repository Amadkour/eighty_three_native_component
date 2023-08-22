import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';

class CongratulationDialog {
  final String? dialogSupTitle;

  CongratulationDialog({this.dialogSupTitle, required BuildContext context}) {
    showDialog(
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
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
                      MyImage.assets(
                        url: 'assets/images/register_confirmation.png',
                        height: 188,
                        width: 260,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      AutoSizeText(
                        tr('Congratulations!'),
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
                      AutoSizeText(
                        tr(dialogSupTitle ?? ''),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Plain',
                          color: AppColors.blackColor.withOpacity(.8),
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
