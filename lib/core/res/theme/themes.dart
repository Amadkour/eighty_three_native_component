import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'font_styles.dart';

ThemeData lightTheme = ThemeData(
    cupertinoOverrideTheme: const CupertinoThemeData(
      brightness: Brightness.light,
    ),
    primaryColor: AppColors.primaryColor,
    backgroundColor: AppColors.blackColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    fontFamily: "Plain",
    primarySwatch: Colors.green,
    dividerColor: AppColors.systemBodyColor,
    dividerTheme: const DividerThemeData(
      space: 1,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      elevation: 0,
      titleTextStyle: appBarStyle.copyWith(
        fontFamily: "SansArabic",
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
      unselectedLabelStyle: TextStyle(
        color: AppColors.blackColor,
        height: 2,
      ),
      selectedLabelStyle: TextStyle(
        color: AppColors.blackColor,
        height: 2,
      ),
      unselectedItemColor: AppColors.otpBorderColor,
      selectedItemColor: AppColors.blackColor,
    ),
    bottomAppBarColor: Colors.black);
