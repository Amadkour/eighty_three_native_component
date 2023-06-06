import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:eighty_three_native_component/core/res/src/constant/shared_orefrences_keys.dart';
import 'package:eighty_three_native_component/core/res/src/provider/api/api_connection.dart';
import 'package:eighty_three_native_component/core/res/src/routes/routes_name.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'custom_success_dialog.dart';
import 'error_dialog.dart';

void show400Dialog(DioError error, {required APIConnection apiConnection}) {
  CustomAlertDialog(
      alertIcon: Icon(
        Icons.logout,
        color: AppColors.primaryColor,
        size: 50,
      ),
      title: tr('Bad request'),
      button1String: tr("Retry"),
      button1OnTap: () async {
        apiConnection.dio.fetch(error.requestOptions);
        CustomNavigator.instance.maybePop();
      },
      button2String: tr('Cancel'),
      button2OnTap: () async {
        CustomNavigator.instance.maybePop();
      });
}

void show500Dialog(DioError error, {required APIConnection apiConnection}) {
  final String url = error.requestOptions.path
      .substring(error.requestOptions.baseUrl.length + 1);
  final Map<dynamic, dynamic> headers =
      Map<String, String>.from(error.requestOptions.headers);
  final Map<dynamic, dynamic> query =
      Map<String, String>.from(error.requestOptions.queryParameters);
  final String? contentType = error.requestOptions.contentType;
  final String method = error.requestOptions.method.toUpperCase();
  final dynamic body = error.requestOptions.data;

  CustomAlertDialog(
      title: tr('Server Error'),
      button1String: "Retry",
      button1OnTap: () async {
        CustomNavigator.instance.maybePop();
        if (method == 'GET') {
          await apiConnection.dio.get(
            url,
            options: Options(
              contentType: contentType,
              headers: headers as Map<String, String>,
            ),
            queryParameters: query as Map<String, dynamic>,
          );
        } else {
          await apiConnection.dio.post(
            url,
            data: body as FormData,
            options: Options(
              contentType: contentType,
              headers: headers as Map<String, String>,
            ),
            queryParameters: query as Map<String, dynamic>,
          );
        }
      },
      button2String: tr('tryLater'));
}

void show401Dialog() {
  CustomAlertDialog(
      isTwoButtons: false,
      button1String: '',
      button1OnTap: null,
      alertIcon: Icon(
        Icons.logout,
        color: AppColors.primaryColor,
        size: 50,
      ),
      title: tr('Unauthorized'),
      button2String: tr('logout'),
      button2OnTap: () async {});
}

void show404Dialog({String? title}) {
  try {
    CustomAlertDialog(
        alertIcon: Icon(
          Icons.logout,
          color: AppColors.primaryColor,
          size: 50,
        ),
        title: title ?? tr('Server Error'),
        isTwoButtons: false,
        button1String: '',
        button1OnTap: null,
        button2OnTap: () {
          CustomNavigator.instance.maybePop();
        },
        button2String: 'Cancel');
  } catch (e) {
    ///
  }
}

void showTimeOutDialog(DioError error, {required APIConnection apiConnection}) {
  CustomAlertDialog(
      alertIcon: Icon(
        Icons.logout,
        color: AppColors.primaryColor,
        size: 50,
      ),
      title: tr('internet'),
      button1String: tr("Retry"),
      button1OnTap: () async {
        await apiConnection.dio.fetch(error.requestOptions);
        CustomNavigator.instance.maybePop();
      },
      button2String: tr('Cancel'),
      button2OnTap: () async {
        CustomNavigator.instance.maybePop();
      });
}

void unauthorizedDialog(DioError error,
    {required Future<void> Function() onRemoveSession}) {
  CustomSuccessDialog.instance.show(
    context: globalKey.currentContext,
    canClose: true,
    title: tr('unauthorized_user'),
    subTitle:
        tr('You are unauthorized, please login or sign up to use all features'),
    onPressedFirstButton: () async {
      await onRemoveSession();
      CustomNavigator.instance
          .pushNamedAndRemoveUntil(RoutesName.login, (route) => false);
    },
    onPressedSecondButton: () {},
    imageUrl: 'assets/images/home/guestDialog.svg',
    firstButtonText: tr('Login'),
    bottomWidget: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Spacer(),
        Text(
          tr("Don't Have an Account?"),
          style: TextStyle(
            color: AppColors.textColor3,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        InkWell(
          onTap: () async {
            await onRemoveSession();
            CustomNavigator.instance
                .pushNamedAndRemoveUntil(RoutesName.register, (route) => false);
          },
          child: Text(
            tr('Sign Up'),
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 12,
            ),
          ),
        ),
        const Spacer()
      ],
    ),
  );
}
