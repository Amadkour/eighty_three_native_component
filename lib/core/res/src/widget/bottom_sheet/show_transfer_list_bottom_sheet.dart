import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/widget/alternative_widgets/empty_widget.dart';
import 'package:eighty_three_native_component/core/res/src/widget/base_page.dart';
import 'package:eighty_three_native_component/core/res/src/loading.dart';
import 'package:eighty_three_native_component/core/res/src/widget/message.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/shared/beneficiary/view/list/component/list_of_transfer_types.dart';
import 'package:eighty_three_native_component/core/shared/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> buildTransferListBottomSheet(
    BuildContext context, bool showSalaryOnly) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (BuildContext context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        constraints: BoxConstraints(
            maxHeight:
                showSalaryOnly ? context.height * 0.4 : context.height * 0.8),
        child: BlocProvider<TransferOptionsCubit>.value(
          value: sl<TransferOptionsCubit>(),
          child: BlocBuilder<TransferOptionsCubit, TransferOptionsState>(
              builder: (BuildContext context, TransferOptionsState state) {
            final TransferOptionsCubit transCubit =
                context.read<TransferOptionsCubit>();
            if (state is TransferOptionsErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                MyToast("Connection Error Or Server Error Happen");
              });
            }
            if (state is TransferOptionsLoadingState) {
              return const NativeLoading();
            }
            if (state is TransferOptionsErrorState) {
              return Container();
            }
            return Container(
              decoration: BoxDecoration(
                color: AppColors.lightWhite,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              padding: const EdgeInsets.all(20),
              child: MainScaffold(
                backgroundColor: Colors.transparent,
                scaffold: SingleChildScrollView(
                  child: Wrap(
                    children: <Widget>[
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Container(
                          width: 64,
                          decoration: BoxDecoration(
                            color: AppColors.bottomSheetIconColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                          height: 5,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(tr("Select Transfer"),
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16)),
                      if (!showSalaryOnly) ...[
                        Container(height: 10),
                        TransferTypeTitle(title: tr('INTERNATIONAL TRANSFER')),
                        Container(height: 10),
                        if (transCubit.internationalTransferTypes!.isEmpty)
                          EmptyWidget(
                            height: 80,
                            message: tr("No International Transfers Yet"),
                          )
                        else
                          ListOfTransferTypes(
                              title: tr('INTERNATIONAL TRANSFER'),
                              keyValue: 'INTERNATIONAL TRANSFER',
                              types: transCubit.internationalTransferTypes!),
                        Container(height: 20),
                        TransferTypeTitle(title: tr("LOCAL TRANSFER")),
                        Container(height: 10),
                        if (transCubit.internationalTransferTypes!.isEmpty)
                          EmptyWidget(
                            height: 80,
                            message: tr("No Local Transfers Yet"),
                          )
                        else
                          ListOfTransferTypes(
                              keyValue: 'LOCAL TRANSFER',
                              title: tr("LOCAL TRANSFER"),
                              types: transCubit.localTransferTypes!),
                        Container(height: 20),
                        TransferTypeTitle(
                            title: tr('salary_transfer').toUpperCase()),
                      ],
                      Container(height: 10),
                      if (transCubit.salaryTransferTypes!.isEmpty)
                        EmptyWidget(
                          height: 80,
                          message: tr("No Salary Transfers Yet"),
                        )
                      else
                        ListOfTransferTypes(
                            title: tr("salary_transfer"),
                            keyValue: "salary_transfer",
                            types: transCubit.salaryTransferTypes!),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            );
          }),
        )),
  );
}

class TransferTypeTitle extends StatelessWidget {
  final String title;
  const TransferTypeTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            color: const Color(0xff2E3B4C).withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1));
  }
}
