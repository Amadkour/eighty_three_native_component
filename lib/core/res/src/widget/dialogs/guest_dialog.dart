import 'package:eighty_three_native_component/core/res/src/constant/widget_keys.dart';
import 'package:eighty_three_native_component/core/res/src/routes/routes_name.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/dialogs/custom_success_dialog.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';

class GuestDialog extends StatelessWidget {
  const GuestDialog({
    super.key,
    required this.child,
    this.onPressedFirstButton,
    this.onPressedSecondButton,
  });
  final Widget child;
  final void Function()? onPressedFirstButton;
  final void Function()? onPressedSecondButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        CustomSuccessDialog.instance.show(
          context: context,
          canClose: true,
          title: tr('guest_mode'),
          subTitle: tr(
              'You are in guest mode, please login or sign up to use all features'),
          onPressedFirstButton: () async {
            /// add these methods to reset dependencies again when login
            await CustomDependencyInjection.reInitialize();
            onPressedFirstButton?.call();
            CustomNavigator.instance.pushNamed(RoutesName.login);
          },
          onPressedSecondButton: onPressedSecondButton,
          imageUrl: 'assets/images/home/guestDialog.svg',
          firstButtonText: tr('login'),
          bottomWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                tr("don't_have_account"),
                style: TextStyle(
                  color: AppColors.textColor3,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Plain',
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                key: goToSignUpKey,
                onTap: () {
                  CustomNavigator.instance.pushNamed(RoutesName.register);
                },
                child: Text(
                  tr('sign_up'),
                  style: const TextStyle(
                    fontFamily: 'Plain',
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: AbsorbPointer(
        ignoringSemantics: true,
        child: child,
      ),
    );
  }
}
