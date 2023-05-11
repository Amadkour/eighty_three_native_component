import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/material.dart';

class EmptyAddDottedWidget extends StatelessWidget {
  const EmptyAddDottedWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DottedBorder(
        color: const Color(0xffACB1B3),
        borderType: BorderType.RRect,
        radius: const Radius.circular(15),
        dashPattern: const <double>[10, 10, 10, 10],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            color: Colors.white,
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  Icon(
                    Icons.add,
                    color: AppColors.blueTextColor,
                  ),
                  AutoSizeText(
                    title,
                    style: TextStyle(color: AppColors.blueTextColor),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
