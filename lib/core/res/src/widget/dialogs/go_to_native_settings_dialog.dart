import 'dart:io';

import 'package:eighty_three_native_component/core/res/src/constant/shared_orefrences_keys.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/global_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/widget/button/loading_button.dart';
import 'package:eighty_three_native_component/core/res/theme/font_styles.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// ignore: avoid_classes_with_only_static_members
class GoToNativeSettingsDialog {
  static void dialog(BuildContext context,String description) {
    showDialog(
        context: globalKey.currentContext!,
        barrierDismissible: true,
        builder: (_) {
          return Directionality(
            textDirection:!isArabic ? TextDirection.rtl:TextDirection.ltr,
            child: AlertDialog(
              title: Column(
                children: <Widget>[
                  SizedBox(
                    child: Text(
                      tr(description),
                      style: headlineStyle.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: LoadingButton(
                            isLoading: false,
                            title: "open_settings",
                            topPadding: 0,
                            onTap: () {
                              if (Platform.isAndroid) {
                                SystemNavigator.pop();
                              } else if (Platform.isIOS) {
                                exit(0);
                              }
                            }
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}