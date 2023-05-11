import 'dart:collection';

import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';
import 'package:intl/intl.dart';

class FromMap {
  final Map<String, dynamic> map;

  FromMap({this.map = const <String, dynamic>{}});

  String? convertToString({
    required String key,
    String? defaultValue,
    Map<String, dynamic>? innerMap,
  }) {
    final Map<String, dynamic> usedMap = innerMap ?? map;
    final String? result = usedMap[key]?.toString().trim() ?? defaultValue;

    /// remove fractions
    // try {
    //   return int.parse(result ?? '').toString();
    // } catch (_) {
    //   try {
    //     return double.tryParse(result ?? '')?.toStringAsFixed(2);
    //   } catch (_) {
    return result;
  }
  //   }
  // }

  bool? convertToBool(
      {required String key,
      bool? defaultValue,
      Map<String, dynamic>? innerMap}) {
    final Map<String, dynamic> usedMap = innerMap ?? map;
    if (usedMap[key] is bool?) {
      return (usedMap[key] as bool?) ?? defaultValue;
    } else {
      final String? result = usedMap[key]?.toString().toLowerCase();
      if (<String>["true", "1"].contains(result)) {
        return true;
      } else if (<String>["false", "0"].contains(result)) {
        return false;
      } else {
        return defaultValue;
      }
    }
  }

  int? convertToInt(
      {required String key,
      int? defaultValue,
      Map<String, dynamic>? innerMap}) {
    final Map<String, dynamic> usedMap = innerMap ?? map;
    if (usedMap[key] is int?) {
      return (usedMap[key] as int?) ?? defaultValue;
    } else {
      final String? value = usedMap[key]?.toString();
      final int? result = int.tryParse(value ?? "") ?? defaultValue;
      return result;
    }
  }

  double? convertToDouble({
    required String key,
    double? defaultValue,
    Map<String, dynamic>? innerMap,
  }) {
    final Map<String, dynamic> usedMap = innerMap ?? map;
    if (usedMap[key] is double?) {
      ///remove fraction
      return ((usedMap[key] as double?) ?? defaultValue) ?? 0.roundToDouble();
    } else {
      String? value = usedMap[key]?.toString();
      if ((value?.contains('.') ?? false) && (value?.contains(',') ?? false)) {
        value = value?.split(',').join();
      }
      final double? result = double.tryParse(value ?? "") ?? defaultValue;

      ///remove fraction
      return result ?? 0.roundToDouble();
    }
  }

  List<T> convertToListOFModel<T extends ParentModel>(
      {dynamic jsonData, dynamic modelInstance}) {
    final T t = modelInstance as T;
    return jsonData is List<dynamic>
        ? List<T>.from(jsonData.map((dynamic x) {
            return t.fromJsonInstance(x as Map<String, dynamic>);
          }))
        : <T>[];
  }

  List<String> convertToListOFString(dynamic jsonData) {
    return jsonData is List<dynamic>
        ? jsonData.cast<String>()
        : jsonData is List<String>
            ? jsonData
            : jsonData is LinkedHashMap<String, dynamic>
                ? jsonData.values.toList().cast<String>()
                : <String>[];
  }

  List<DateTime> convertToDateTimeList(
      {dynamic jsonData, DateFormat? dateFormat}) {
    final DateFormat usedDateFormat = dateFormat ?? DateFormat('dd-MM-yyyy');

    return jsonData is List<dynamic>
        ? jsonData
            .map((dynamic e) => usedDateFormat.parse(e.toString()))
            .toList()
        : <DateTime>[];
  }

  DateTime? convertToDateTime({required String key}) {
    if (map[key] != null) {
      return DateTime.parse(map[key] as String);
    }
    return null;
  }

  T convertToEnum<T>(String key, List<T> values) {
    return values.firstWhere(
        (element) => element.toString().split(".").last == map[key]);
  }
}
