import 'package:eighty_three_native_component/core/res/src/cubit/date_picker/controller/date_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/button/loading_button.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showActiveDateSheet(
    BuildContext context,
    void Function(String) onChange,
    String? date,
    ) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => BlocProvider(
        create: (context) => DateCubit(currentDate: date, haveDay: false),
        child: BlocBuilder<DateCubit, DateState>(
          builder: (context, state) {
            DateCubit dateCubit = context.read<DateCubit>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              FocusScope.of(context).nextFocus();
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close,
                                color: Colors.black, size: 15),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Expanded(
                                flex: 2,
                                child: months(context, (String v) {
                                  dateCubit.setMonth(v);
                                }, dateCubit)),
                            const SizedBox(
                              width: 40,
                            ),
                            Expanded(
                                flex: 2,
                                child: years(context, (String v) {
                                  dateCubit.setYear(v);
                                }, dateCubit)),
                            const Expanded(
                              child: SizedBox(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          child: LoadingButton(
                              key: const Key('confirm_date_key'),
                              topPadding: 0,
                              isLoading: false,
                              title: tr("done"),
                              onTap: () {
                                final String date =
                                    '${dateCubit.month}/${dateCubit.year}';
                                onChange(date);
                                CustomNavigator.instance.pop();
                                FocusScope.of(context).nextFocus();
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ));
}

Widget months(BuildContext context, ValueChanged<String> onMonthChanged,
    DateCubit dateCubit) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      OvalTitle(title: tr("month")),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
              initialItem: int.parse(
                  dateCubit.month!.replaceAll(RegExp(r'^0+(?=.)'), '')) -
                  1),
          key: const ValueKey<String>('month'),
          itemExtent: 50,
          looping: true,
          onSelectedItemChanged: (int index) {
            onMonthChanged(dateCubit.monthValue[index]);
          },
          children: dateCubit.monthValue.map((String i) {
            return Center(
              key: ValueKey<String>(i),
              child: Text(i,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w400)),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

Widget years(BuildContext context, ValueChanged<String> onYearChanged,
    DateCubit dateCubit) {
  final List<int> yearValues =
  List<int>.generate(100, (int index) => DateTime.now().year + index);
  return Column(
    key: const Key("years_date_list_key"),
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      OvalTitle(title: tr("year")),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
              initialItem: yearValues.indexOf(int.parse(dateCubit.year!))),
          key: const ValueKey<String>('year'),
          itemExtent: 50,
          looping: true,
          useMagnifier: true,
          onSelectedItemChanged: (int index) {
            onYearChanged(yearValues[index].toString());
          },
          children: yearValues.map((int i) {
            return Center(
              child: Text(i.toString(),
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w400)),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

Widget days(BuildContext context, ValueChanged<String> onDayChanged,
    DateCubit dateCubit) {
  return Column(
    key: const Key("years_date_list_key"),
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      OvalTitle(title: tr("day")),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
              initialItem: int.parse(dateCubit.day!) - 1),
          key: const ValueKey<String>('year'),
          itemExtent: 50,
          looping: true,
          useMagnifier: true,
          onSelectedItemChanged: (int index) {
            onDayChanged(dateCubit.getDaysNumber()[index].toString());
          },
          children: dateCubit.getDaysNumber().map((String i) {
            return Center(
              child: Text(i,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w400)),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

class OvalTitle extends StatelessWidget {
  final String title;
  const OvalTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
          color: Color(0xffF4F4F4),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Text(
        title,
        style: const TextStyle(color: Color(0xff121212)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
