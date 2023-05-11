import 'package:eighty_three_native_component/core/res/src/constant/widget_keys.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/bottom_sheet/date_bottom_sheet.dart';
import 'package:eighty_three_native_component/core/res/src/widget/bottom_sheet/date_picker/controller/date_cubit/date_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/widget/button/loading_button.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/res/theme/font_styles.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showScrollableDatePickerBottomSheet({
  required BuildContext context,
  required void Function(String) onChange,
  required String? date,
}) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => BlocProvider(
            create: (context) => DateCubit(currentDate: date, haveDay: true),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                tr("execution_date"),
                                style: paragraphStyle.copyWith(
                                    color: AppColors.blackColor, fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: years(context, (String v) {
                                      dateCubit.setYear(v);
                                    }, dateCubit)),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: months(context, (String v) {
                                      dateCubit.setMonth(v);
                                    }, dateCubit)),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: days(context, (String v) {
                                      dateCubit.setDay(v);
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
                                  key: confirmDateKey,
                                  topPadding: 0,
                                  isLoading: false,
                                  title: tr("save_changes"),
                                  onTap: () {
                                    final String date =
                                        '${dateCubit.day}/${dateCubit.month}/${dateCubit.year}';
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
          )).whenComplete(() => FocusScope.of(context).nextFocus());
}
