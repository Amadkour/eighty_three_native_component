part of 'my_image.dart';

class _SvgImageAssets extends MyImage {
  const _SvgImageAssets({
    super.key,
    double height = 100,
    double width = 100,
    super.color,
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
    return url.isEmpty && defaultUrl.isEmpty
        ? AppLogo(
            width: width,
            height: height,
            borderRadius: borderRadius,
          )
        : SvgPicture.asset(
            url,
            width: width,
            height: height,
            fit: fit!,
            color: color,
            placeholderBuilder: (BuildContext v) {
              return CircularProgressIndicator(
                color: AppColors.backgroundColor,
              );
            },
          );
  }
}

class _AssetImage extends MyImage {
  const _AssetImage({
    super.key,
    double height = 100,
    double width = 100,
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
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: url.isEmpty && defaultUrl.isEmpty
          ? AppLogo(
              width: width,
              height: height,
              borderRadius: borderRadius ?? 180,
            )
          : Image.asset(
              url,
              width: width,
              height: height,
              fit: fit,
              errorBuilder:
                  (BuildContext context, Object child, StackTrace? error) =>
                      defaultUrl.isNotEmpty
                          ? Image.asset(
                              defaultUrl,
                              height: height,
                              width: width,
                              fit: fit,
                            )
                          : AppLogo(
                              width: width,
                              height: height,
                              borderRadius: borderRadius ?? 180,
                            ),
            ),
    );
  }
}
