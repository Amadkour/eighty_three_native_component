import 'package:flutter/material.dart';

class ResAppImage extends StatelessWidget {
  const ResAppImage({
    super.key,
    this.height,
    this.width,
    this.isEditableImage=false,
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
          color: withBackground ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(
            borderRadius ?? 120,
          ),
        ),
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          "assets/icons/res_logo.webp",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
