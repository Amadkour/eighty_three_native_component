import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.child,
    this.onPressed,
    this.color,
    this.padding = 8,
  });
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      minWidth: 40,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: onPressed,
      highlightElevation: 0,
      shape: const CircleBorder(),
      color: color ?? AppColors.pointButtonColor.withOpacity(0.1),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
