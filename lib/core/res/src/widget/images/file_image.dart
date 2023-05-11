part of 'my_image.dart';

class _FileImage extends MyImage {
  const _FileImage({
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
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
      child: Image.file(
        File(url),
        fit: fit,
        height: height,
        width: width,
        errorBuilder: (BuildContext context, Object child, StackTrace? error) {
          return Image.asset(
            defaultUrl,
            height: height,
            width: width,
            fit: fit,
          );
        },
      ),
    );
  }
}
