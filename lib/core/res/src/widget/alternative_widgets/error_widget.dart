import 'package:auto_size_text/auto_size_text.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String? message;

  final bool showMessage;

  final bool showImage;
  final double? height;
  final double? width;

  final Widget? image;

  const MyErrorWidget({
    super.key,
    this.message,
    this.showMessage = true,
    this.showImage = true,
    this.height = 100,
    this.width = 400,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: (height ?? 200) / 2),
            child: Column(
              children: <Widget>[
                if (showImage)
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      image ??
                          MyImage.svgAssets(
                            url: 'assets/images/empty.svg',
                            width: width!,
                            height: height!,
                          ),
                    ],
                  ),
                if (showMessage)
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      AutoSizeText(
                        message ?? tr('empty'),
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontFamily: 'Bold',
                            fontSize: 18),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
