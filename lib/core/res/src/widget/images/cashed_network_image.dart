import 'package:cached_network_image/cached_network_image.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/src/loading.dart';
import 'package:flutter/material.dart';

class CashedNetworkImage extends MyImage {
  const CashedNetworkImage({
    super.key,
    double height = 105,
    double width = 105,
    BoxFit fit = BoxFit.fill,
    required super.url,
    double borderRadius = 5.0,
  }) : super(
          borderRadius: borderRadius,
          fit: fit,
          width: width,
          height: height,
        );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
      child: CachedNetworkImage(
        imageUrl: url,
        width: height,
        height: width,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const NativeLoading(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
