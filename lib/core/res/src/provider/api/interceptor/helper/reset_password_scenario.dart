import 'package:eighty_three_native_component/core/res/src/routes/routes_name.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/message.dart';
import 'package:flutter/material.dart';

void resetPasswordScenario() {
  if (CustomNavigator.instance.currentScreenName != RoutesName.forgetPassword) {
    CustomNavigator.instance.pushNamedAndRemoveUntil(
        RoutesName.forgetPassword, (Route<dynamic> route) => false);
  }
  MyToast("please, change your password");
}
