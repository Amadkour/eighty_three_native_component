import 'package:eighty_three_native_component/core/res/src/constant/shared_orefrences_keys.dart';
import 'package:flutter/material.dart';

RegExp numberRegExp = RegExp(r"\D");
final alphabetic = RegExp(r'^[a-z]+$');

extension Cleaining on TextEditingController {
  String get removeNonNumber => text.replaceAll(numberRegExp, "");

  bool get isNumeric {
    try {
      return double.tryParse(removeNonNumber) != null;
    } catch (_) {
      return false;
    }
  }
}
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

// rename it to size extension because it make conflict wit ui size class

extension SizeExtension on BuildContext {
  double get height => MediaQuery.of(globalKey.currentContext!).size.height;

  double get bottomPadding =>
      MediaQuery.of(globalKey.currentContext!).padding.bottom;

  double get width => MediaQuery.of(globalKey.currentContext!).size.width;

  ThemeData get theme => Theme.of(globalKey.currentContext!);

  bool get isTablet => MediaQuery.of(this).size.shortestSide > 600;
}

extension DateTimeConstrain on DateTime {
  ///return true if user age < 18 years
  bool isUnderAge() => DateTime.now().difference(this).inDays < 6574;
  bool isEqual(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }
}

extension ListExtensions<T> on Iterable<T> {
  T? whereOrNull(bool Function(T) test) {
    for (final T element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

extension OnTap on InkWell {
  void onTap() {}
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

extension CustomString on String? {
  int? parseToInt() {
    return int.tryParse(this?.toString().replaceAll(',', '') ?? '');
  }

  double? parseToDouble() {
    return double.tryParse(this?.toString().replaceAll(',', '') ?? '');
  }

  Color toColor() {
    final StringBuffer buffer = StringBuffer();
    if (this?.length == 6 || this?.length == 7) buffer.write('ff');
    buffer.write(this?.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String get removeNonNumber {
    return toString().replaceAll(numberRegExp, "");
  }

  String get removeComma {
    return toString().replaceAll(",", "");
  }

  String get amountFormatter {
    String newSalary = this ?? "0";
    if (this?.length == 4) {
      newSalary = '${this?[0]},${this?.substring(1)}';
    } else if (this?.length == 5) {
      newSalary = (this ?? "0").replaceAll(",", "");
      newSalary = '${this?.substring(0, 2)},${this?.substring(2)}';
    } else if ((this ?? "0").length > 5) {
      newSalary = (this ?? "0").replaceAll(",", "");
      newSalary = '${this?.substring(0, 3)},${this?.substring(3)}';
    }
    return newSalary;
  }

  String capitalize() {
    return (this?[0].toUpperCase() ?? "") + (this?.substring(1) ?? "");
  }

  bool get isAlphabetOnly {
    return alphabetic.hasMatch(this!);
  }

  bool get isNumericOnly {
    return numberRegExp.hasMatch(this!);
  }
}
