import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateState> {
  DateCubit({this.currentDate, required bool haveDay}) : super(DateInitial()) {
    if (currentDate != null && currentDate!.isNotEmpty) {
      if (haveDay) {
        setDay(currentDate!.split("/")[0]);
        setMonth(currentDate!.split("/")[1]);
        setYear(currentDate!.split("/").last);
      } else {
        setMonth(currentDate!.split("/").first);
        setYear(currentDate!.split("/").last);
      }
    } else {
      month = "01";
      day = "01";
      year = (DateTime.now().year).toString();
    }
  }

  String? currentDate;
  bool haveDay = false;

  String? month;
  String? day;
  String? year = (DateTime.now().year).toString();

  final List<String> monthDays = List<String>.generate(
      31, (int index) => (index + 1).toString().padLeft(2, '0'));

  final List<String> monthValue = <String>[
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];

  List<String> getDaysNumber() {
    if (month == "02") {
      return monthDays.take(28).toList();
    } else if ([
      '04',
      '06',
      '09',
      '11',
    ].contains(month)) {
      return monthDays.take(30).toList();
    } else {
      return monthDays;
    }
  }

  void setMonth(String newMonth) {
    month = newMonth;
    emit(DateInitial());
  }

  void setYear(String year) {
    this.year = year;
    emit(DateInitial());
  }

  void setDay(String newDay) {
    day = newDay;
    emit(DateInitial());
  }
}
