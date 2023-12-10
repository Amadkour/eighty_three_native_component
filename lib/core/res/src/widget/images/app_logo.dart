import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.height,
    this.width,
    this.isEditableImage = false,
    this.borderRadius,
    this.withBackground = true,
  });
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool withBackground;
  final bool isEditableImage;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 120,
          ),
        ),
        width: width,
        height: height,
        child: MyImage.svgAssets(
          url: "assets/images/logo.jpg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
