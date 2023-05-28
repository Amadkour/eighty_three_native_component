extension SaudiExtension on String {
  String get saudi {
    String value = this;
    if (value.startsWith('966')) {
      value = value.substring(3);
    } else if (value.startsWith('+966')) {
      value = value.substring(4);
    }

    return value;
  }
}
