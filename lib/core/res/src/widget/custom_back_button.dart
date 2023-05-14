import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onBack,
  });

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "back",
      onPressed: () {
        if (onBack != null) {
          onBack?.call();
        } else {
          CustomNavigator.instance.pop();
        }
      },
      icon: RotatedBox(
        quarterTurns: currentUserPermission.isArabic ? 2 : 0,
        child: SvgPicture.asset("assets/icons/back.svg"),
      ),
    );
  }
}
