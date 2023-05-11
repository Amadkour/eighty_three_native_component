RegExp _email = RegExp(
    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
RegExp _numeric = RegExp(r'^-?[0-9]+$');

const List<String> _english = <String>['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
const List<String> _arabic = <String>['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
const List<String> _persian = <String>['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

String replaceArabicNumbers(String text) {
  String input = text;
  for (int i = 0; i < _arabic.length; i++) {
    input = input.replaceAll(_arabic[i], _english[i]);
  }
  for (int i = 0; i < _persian.length; i++) {
    input = input.replaceAll(_persian[i], _english[i]);
  }
  return input;
}

/// check if the string is an email
bool isEmail(String str) {
  return _email.hasMatch(str.toLowerCase());
}

bool isValidEmail(String str) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(removeWhitespace(str));
}

String removeWhitespace(String str) {
  return str.replaceAll(RegExp(r"\s+\b|\b\s"), "");
}

bool isMobile(String value) {
  const String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  final RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

/// check if the string contains only numbers
bool isNumeric(String str) {
  return _numeric.hasMatch(str);
}

bool isSaudiMobile(String value) {
  const String pattern = r'(?:\+?0*?966)?0?5[0-9]{8}';
  final RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}
