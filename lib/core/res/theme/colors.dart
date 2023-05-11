import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
abstract class AppColors {
  static Color textColor1 = const Color(0xff534C4C);
  static Color darkColor = const Color(0xff000000);
  static Color textColor2 = const Color(0xff7C7C7C);
  static Color textColor3 = const Color(0xff5A6367);
  static Color textColor4 = const Color(0xff929292);
  static Color greenColor = const Color.fromRGBO(78, 200, 158, 1);
  static Color pointButtonColor = const Color.fromRGBO(60, 207, 78, 1);
  static Color descriptionColor = const Color.fromRGBO(90, 99, 103, 1);
  static Color secondaryColor = const Color.fromRGBO(38, 38, 38, 1);
  static Color systemBodyColor = const Color.fromRGBO(90, 99, 103, 1);
  static Color blueColor = const Color.fromRGBO(44, 100, 227, 1);
  static Color blueColor2 = const Color(0xff158CEA);
  static Color primaryColor = const Color(0xFF0F1737);
  static Color darkBlueColor = const Color(0xff2C64E3);
  static Color borderColor = const Color(0xffEDEDED);
  static Color blackColor = const Color(0xff262626);
  static Color blueTextColor = const Color(0xff158CEA);
  static Color hintTextColor = const Color(0xffC4C5C4);
  static Color backgroundColor = const Color(0xffF9F9F9);
  static Color otpBorderColor = const Color(0xff5A6367);
  static Color otpBackgroundColor = const Color(0xffF6F9FA);
  static Color withdrawTextColor = const Color(0xff2E3B4C);
  static Color bottomSheetIconColor = const Color(0xffBEBEBE);
  static Color lightGreen = const Color(0xFF4EC89E);
  static Color shadow = Colors.black.withOpacity(0.3);
  static Color lightGreen2 = const Color(0xffECFAED);
  static Color lightBlue = const Color(0xffE8F4FD);
  static Color greyColor = const Color(0xffD4D4D4);
  static Color darkGrayColor = const Color(0xff8E959E);
  static Color eyeVisibleColor = const Color(0xffDDEAF3);
  static Color grayTextColor = const Color(0xff5A6367);
  static Color lightPink = const Color(0xffFDE6E8);
  static Color navy = const Color.fromRGBO(15, 28, 76, 1);
  static Color celebrityProductContainerColor =
      const Color.fromRGBO(37, 37, 37, 1);
  static Color unSelectedFilterBackground =
      const Color.fromRGBO(247, 247, 247, 1);
  static Color orange = const Color.fromRGBO(250, 155, 15, 1);
  static Color purple = const Color.fromRGBO(170, 82, 255, 1);
  static Color cyan = const Color.fromRGBO(0, 222, 254, 1);
  static Color stepperCompletedColor = const Color.fromRGBO(224, 224, 224, 1);
  static Color redColor = const Color.fromRGBO(213, 83, 83, 1);

  static Color lightWhite = const Color(0xffF9F9F9);
  static List<Color> randomColorList = <Color>[
    orange,
    greenColor,
    purple,
    blueTextColor,
    cyan,
    navy,
    redColor,
    orange,
  ];

  static Color getTransactionColor(String type) {
    late Color color;
    switch (type) {
      case "bills":
        color = orange;

        break;
      case "transfer":
        color = redColor;

        break;

      case "deposit":
        color = greenColor;

        break;
      case "gift":
        color = cyan;

        break;
      case "qr pay":
        color = blueTextColor;

        break;
      case "withdraw":
        color = purple;
        break;
      case "refund":
            color = purple;
            break;

      default:
        color = greenColor;
    }

    return color;
  }
}
