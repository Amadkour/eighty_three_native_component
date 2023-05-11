import 'package:eighty_three_native_component/core/res/src/constant/shared_orefrences_keys.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  CustomAlertDialog(
      {required String? button1String,
      required void Function()? button1OnTap,
      required String? title,
      Widget? alertIcon,
      String? subTitle,
      String? button2String,
      void Function()? button2OnTap,
      bool isTwoButtons = true,
      bool? isLoading}) {
    const double height = double.maxFinite;
    title ??= '';
    isLoading ??= false;

    showDialog(
        builder: (_) => Padding(
            padding: const EdgeInsets.only(
                top: height * 1 / 6,
                right: 25,
                left: 25,
                bottom: height * 1 / 6),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Material(
                    type: MaterialType.transparency,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        alertIcon!,
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Bold'),
                        ),
                        if (subTitle != null) const SizedBox(height: 10),
                        if (subTitle != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(subTitle,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Plain')),
                          ),
                        const SizedBox(
                          height: 15,
                        ),
                        if (button2String != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: drawButton(
                                  onPressed: button2OnTap ??
                                      () {
                                        // CustomNavigator.instance.maybePop();
                                      },
                                  text: tr(button2String)),
                            ),
                          ),
                        const SizedBox(
                          height: 15,
                        ),
                        if (isTwoButtons)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primaryColor,
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  side:
                                      BorderSide(color: AppColors.primaryColor),
                                ),
                                onPressed: button1OnTap,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(tr(button1String!),
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                      )),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
        context: globalKey.currentContext!);
  }

  Widget drawButton(
          {required String text,
          required void Function() onPressed,
          Color? color,
          bool isLoading = false}) =>
      ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
          alignment: AlignmentDirectional.center,
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          backgroundColor:
              MaterialStateProperty.all(color ?? AppColors.primaryColor),
          minimumSize: MaterialStateProperty.all(const Size(100, 45)),
        ),
        onPressed: onPressed,
        child: Center(
          child: FittedBox(
            child: isLoading
                ? const SizedBox(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Bold',
                        fontSize: 16,
                      ),
                    ),
                  ),
          ),
        ),
      );
}
