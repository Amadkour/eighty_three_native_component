import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToast {
  MyToast(
    String snackMessage, {
    Color? fontColor,
    Color? background,
  }) {
    _showToast(
      snackMessage,
      fontColor: fontColor,
      background: background,
    );
  }

  ///This show success toast with green background color
  MyToast.success(String snackMessage) {
    _showToast(snackMessage, background: AppColors.greenColor);
  }
  static void _showToast(
    String snackMessage, {
    Color? fontColor,
    Color? background,
  }) {
    // ScaffoldMessenger.of(globalKey.currentState!.context).showSnackBar(
    //   SnackBar(
    //     content: Text(snackMessage,
    //         style: Theme.of(globalKey.currentState!.context)
    //             .textTheme
    //             .subtitle1!
    //             .copyWith(color: fontColor ?? Colors.white)),
    //     backgroundColor: background,
    //     duration: const Duration(seconds: 2),
    //   ),
    // );
    Fluttertoast.showToast(
      msg: snackMessage,
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      backgroundColor: background,
      fontSize: 16.0,
    );
  }
}
