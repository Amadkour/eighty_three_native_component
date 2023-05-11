
import 'package:auto_size_text/auto_size_text.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class SingleCategoryTabItem extends StatelessWidget {
  final String label;
  final bool isThisCurrentIndex;
  final double? width;
  const SingleCategoryTabItem({
    super.key,required this.label,required this.isThisCurrentIndex,this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isThisCurrentIndex?AppColors.lightGreen.withOpacity(0.2):const Color(0xffF7F7F7),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      height: 32,
      width: width,
      child: AutoSizeText(tr(label),style: TextStyle(
          color: isThisCurrentIndex?AppColors.lightGreen:AppColors.blackColor,fontSize: 13,fontWeight: isThisCurrentIndex?
      FontWeight.w600:FontWeight.w400,overflow: TextOverflow.ellipsis
      ),maxLines: 1),
    );
  }
}
