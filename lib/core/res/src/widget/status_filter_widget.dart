import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/res/theme/font_styles.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class StatusFilterWidget extends StatelessWidget {
  const StatusFilterWidget({
    super.key,
    required this.name,
    this.itemKey,
    required this.isActive,
    required this.onPressed,
  });

  final String name;
  final String? itemKey;
  final bool isActive;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: itemKey != null ? Key(itemKey!) : null,
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 6),
        margin: const EdgeInsetsDirectional.only(end: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.greenColor.withOpacity(0.2)
              : AppColors.unSelectedFilterBackground,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          tr(name),
          style: bodyStyle.copyWith(
            color: isActive ? AppColors.greenColor : AppColors.secondaryColor,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
