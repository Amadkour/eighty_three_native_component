part of "my_image.dart";

class _NetworkImage extends MyImage {
  const _NetworkImage({
    super.key,
    super.height,
    double super.width,
    super.color,
    BoxFit super.fit,
    double super.borderRadius,
    required super.url,
    super.defaultUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
      child: FutureBuilder<Uint8List>(
        future: _getImage(url),
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          if (snapshot.hasError) {
            if (defaultUrl.isEmpty) {
              return ResAppImage(
                width: width,
                height: height,
                borderRadius: borderRadius,
              );
            } else {
              return MyImage.assets(
                url: defaultUrl,
                height: height ?? 100,
                width: width ?? 100,
                fit: fit ?? BoxFit.cover,
              );
            }
          } else if (snapshot.hasData && snapshot.data != null) {
            return Image.memory(
              snapshot.data!,
              width: width,
              height: height,
              fit: fit,
            );
          } else {
            return NativeLoading(
              size: (height ?? 100) / 2,
            );
          }
        },
      ),
    );
  }

}

class _SvgImageNetwork extends MyImage {
  const _SvgImageNetwork({
    super.key,
    double height = 100,
    double width = 100,
    super.color,
    BoxFit fit = BoxFit.fill,
    required super.url,
    double borderRadius = 5.0,
    String defaultImage = '',
  }) : super(
          borderRadius: borderRadius,
          fit: fit,
          width: width,
          height: height,
          defaultUrl: defaultImage,
        );

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty && defaultUrl.isEmpty) {
      return ResAppImage(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );
    }
    return FutureBuilder<Uint8List>(
      future: _getImage(url),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.hasError) {
          if (defaultUrl.isEmpty) {
            return ResAppImage(
              width: width,
              height: height,
              borderRadius: borderRadius,
            );
          } else {
            if (defaultUrl.endsWith('svg')) {
              return MyImage.svgAssets(url: defaultUrl);
            }
            return MyImage.assets(
              url: defaultUrl,
              height: height ?? 100,
              width: width ?? 100,
              fit: fit ?? BoxFit.cover,
            );
          }
        } else if (snapshot.hasData && snapshot.data != null) {
          return SvgPicture.memory(
            snapshot.data!,
            width: width,
            height: height,
          );
        } else {
          return NativeLoading(
            size: height ?? 100 / 3,
          );
        }
      },
    );
  }
}

Future<Uint8List> _getImage(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else {
    throw Exception();
  }
}
