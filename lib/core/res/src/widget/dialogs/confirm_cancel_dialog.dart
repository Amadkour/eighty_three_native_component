import 'package:auto_size_text/auto_size_text.dart';
import 'package:eighty_three_native_component/core/res/src/constant/widget_keys.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/global_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class ConfirmCancelDialog {
  ConfirmCancelDialog({
    required BuildContext context,
    required String title,
    required VoidCallback onConfirm,
    Widget? titleWidget,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Column(
          children: <Widget>[
            Directionality(
              textDirection: !isArabic ? TextDirection.ltr : TextDirection.rtl,
              child: Container(
                height: context.height * 0.1,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.white,
                child: titleWidget ??
                    AutoSizeText(
                      title,
                      style: TextStyle(
                          fontSize: context.width * 0.04,
                          fontWeight: FontWeight.w600),
                    ),
              ),
            ),
            Row(
              textDirection: !isArabic ? TextDirection.ltr : TextDirection.rtl,
              children: <Widget>[
                const Spacer(),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: TextButton(
                    key: cancelButtonDialogKey,
                    onPressed: () {
                      CustomNavigator.instance.pop();
                    },
                    child: AutoSizeText(
                      tr('cancel'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AppColors.blackColor, fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: TextButton(
                    key: confirmButtonDialogKey,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.blackColor)),
                    onPressed: () async {
                      CustomNavigator.instance.pop().then((value) {
                        onConfirm();
                      });
                    },
                    child: AutoSizeText(
                      tr('confirm'),
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
