import 'dart:io';

import 'package:eighty_three_native_component/core/res/src/widget/images/app_logo.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/cashed_network_image.dart';
import 'package:eighty_three_native_component/core/res/src/loading.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
part 'assets_image.dart';

part 'file_image.dart';

part 'network_image.dart';

class MyImage extends StatelessWidget {
  final double? height;
  final double? width;

  final double? borderRadius;
  final bool? isCashed;

  final Color? color;
  final BoxFit? fit;

  final String defaultUrl;

  final String url;

  const MyImage({
    super.key,
    this.height,
    this.width = 100,
    this.color,
    this.fit = BoxFit.fill,
    this.defaultUrl = "",
    required this.url,
    this.borderRadius = 5.0,
    this.isCashed = false,
  });

  factory MyImage.svgAssets({
    Key? key,
    double height = 100,
    double width = 100,
    Color? color,
    BoxFit fit = BoxFit.fill,
    required String? url,
    double borderRadius = 5.0,
  }) {
    final _SvgImageAssets image = _SvgImageAssets(
      key: key,
      url: url ?? '',
      height: height,
      width: width,
      borderRadius: borderRadius,
      color: color,
      fit: fit,
    );
    child = image;
    return image;
  }

  factory MyImage.svgNetwork({
    Key? key,
    double height = 100,
    double width = 100,
    Color? color,
    BoxFit fit = BoxFit.fill,
    required String url,
    double borderRadius = 5.0,
    String? defaultUrl,
  }) {
    final _SvgImageNetwork image = _SvgImageNetwork(
      key: key,
      url:  url.contains('cdn')?url.replaceFirst('public', 'storage'):url,
      height: height,
      width: width,
      borderRadius: borderRadius,
      color: color,
      fit: fit,
      defaultImage: defaultUrl ?? "",
    );
    child = image;
    return image;
  }

  factory MyImage.network({
    Key? key,
    double? height = 100,
    double width = 100,
    bool isCashed = false,
    Color? color,
    String defaultUrl = "",
    BoxFit fit = BoxFit.fill,
    String? url,
    double borderRadius = 5.0,
  }) {
    final MyImage image = (url == null || url.isEmpty)
        ? _AssetImage(
            height: height ?? 100,
            width: width,
            url: defaultUrl,
            borderRadius: borderRadius,
          )
        : _NetworkImage(
            key: key,
            ///remove it when resolve res cdn problem
            url:  url.contains('cdn')?url.replaceFirst('public', 'storage'):url,
            defaultUrl: defaultUrl,
            height: height,
            width: width,
            borderRadius: borderRadius,
            color: color,
            fit: fit,
          );
    child = image;
    return image;
  }
  factory MyImage.cashedNetwork({
    Key? key,
    double height = 100,
    double width = 100,
    BoxFit fit = BoxFit.fill,
    required String url,
    double borderRadius = 5.0,
  }) {
    return CashedNetworkImage(
      key: key,
      url:  url.contains('cdn')?url.replaceFirst('public', 'storage'):url,
      height: height,
      width: width,
      borderRadius: borderRadius,
      fit: fit,
    );
  }
  factory MyImage.assets({
    Key? key,
    double height = 100,
    double width = 100,
    BoxFit fit = BoxFit.fill,
    required String url,
    double borderRadius = 5.0,
  }) {
    final _AssetImage image = _AssetImage(
      key: key,
      url: url,
      height: height,
      width: width,
      borderRadius: borderRadius,
      fit: fit,
    );
    child = image;
    return image;
  }

  factory MyImage.file({
    Key? key,
    double height = 100,
    double width = 100,
    BoxFit fit = BoxFit.fill,
    required String url,
    double borderRadius = 5.0,
  }) {
    final _FileImage image = _FileImage(
      key: key,
      url: url,
      height: height,
      width: width,
      borderRadius: borderRadius,
      fit: fit,
    );
    child = image;
    return image;
  }

  static late Widget child;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
