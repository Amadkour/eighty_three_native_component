import 'package:eighty_three_native_component/core/res/src/constant/shared_orefrences_keys.dart';
import 'package:eighty_three_native_component/core/res/src/constant/widget_keys.dart';
import 'package:eighty_three_native_component/core/res/src/routes/routes_name.dart';

import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/button/loading_button.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class CustomSuccessDialog {
  CustomSuccessDialog._singleTone();

  static final CustomSuccessDialog _instance =
      CustomSuccessDialog._singleTone();

  static CustomSuccessDialog get instance => _instance;

  Future<void> show({
    BuildContext? context,
    String? imageUrl,
    String? title,
    bool? canClose,
    String? subTitle,
    String? firstButtonText,
    String? secondButtonText,
    Widget? bottomWidget,
    bool haveSecondButton = true,
    required void Function() onPressedFirstButton,
    void Function()? onPressedSecondButton,
  }) async {
    await showDialog(
      context: context ?? globalKey.currentContext!,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: loggedInUser.locale == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: WillPopScope(
            ///  Prevents dialog dismiss on press of back button.
            onWillPop: () async => canClose ?? false,
            child: AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 30),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              content: Container(
                width: context.width * 0.85,
                // height: context.height * 0.67,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ///close icon
                    if (canClose ?? false)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color: context.theme.primaryColor)),
                          child: InkWell(
                            child: const Icon(
                              Icons.close,
                              size: 25,
                            ),
                            onTap: () => CustomNavigator.instance.pop(),
                          ),
                        ),
                      ),

                    ///image
                    MyImage.svgAssets(
                      url: imageUrl ?? 'assets/images/success-dialog.svg',
                      width: context.width * 0.6,
                      height: context.height * 0.25,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                      child: Text(
                        title ?? 'Gift Send',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SemiBold',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      subTitle ?? 'Your gift request has been sent',
                      style: TextStyle(
                          color: AppColors.textColor3.withOpacity(.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Plain'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    haveSecondButton
                        ? LoadingButton(
                            key: viewEReceiptKey,
                            onTap: onPressedFirstButton,
                            title: firstButtonText ?? tr("view_e_receipt"),
                            isLoading: false,
                            topPadding: 0,
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 12,
                    ),
                    bottomWidget ??
                        LoadingButton(
                          key: backToHomeDialogKey,
                          onTap: onPressedSecondButton ??
                              () {
                                CustomNavigator.instance.pushReplacementNamed(
                                    RoutesName.authDashboard);
                              },
                          title: secondButtonText ?? tr("back_to_home"),
                          backgroundColor: Colors.transparent,
                          fontColor: Colors.blue,
                          isLoading: false,
                          topPadding: 0,
                        ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      barrierDismissible: canClose ?? false,
    );
  }
}
