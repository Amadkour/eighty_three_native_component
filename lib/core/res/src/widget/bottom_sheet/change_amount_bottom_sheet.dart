import 'package:eighty_three_native_component/core/res/src/constant/widget_keys.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:eighty_three_native_component/core/res/src/widget/button/loading_button.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/child/amount_text_field.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/shared/amount/controller/transaction_amount_cubit.dart';
import 'package:eighty_three_native_component/core/shared/beneficiary/controller/beneficiary_cubit.dart';
import 'package:eighty_three_native_component/core/shared/transfer/provider/model/beneficary_model.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void EnterAmountSheet({
  required BuildContext context,
  required Beneficiary beneficiary,
  required String buttonTitle,
}) {
  showCustomBottomSheet(
      context: context,
      hasButtons: false,
      title: "",
      isTwoButtons: false,
      body: ListOfWidgets(
        beneficiary: beneficiary,
        buttonTitle: buttonTitle,
      ));
}

class ListOfWidgets extends StatelessWidget {
  ListOfWidgets({
    super.key,
    required this.beneficiary,
    required this.buttonTitle,
  });
  final Beneficiary beneficiary;
  final String buttonTitle;
  final List<String> numberList = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
    '00'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<BeneficiaryCubit>(),
      child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: context.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 46),
                      child: AmountTextField.transferAmount(
                        readOnly: true,
                        isLocal: true,
                        controller: sl<BeneficiaryCubit>().amountTextField,
                        key: amountTextFieldKey,
                        autoFocus: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SafeArea(
                child: AnimatedContainer(
                  padding: const EdgeInsets.only(top: 30, bottom: 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  duration: const Duration(seconds: 2),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 4 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      ...List<Widget>.generate(
                        numberList.length,
                        (int index) => InkWell(
                          key: Key("pin_code_${numberList[index]}"),
                          onTap: () {
                            sl<BeneficiaryCubit>()
                                .updateAmountTextField(numberList[index]);
                            formatAmountText(
                                sl<BeneficiaryCubit>().amountTextField);
                          },
                          child: Text(
                            numberList[index],
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 32,
                                fontFamily: 'Plain',
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: InkWell(
                          key: const Key("remove_letter"),
                          onTap: () {
                            sl<BeneficiaryCubit>().removeLastChar();
                            sl<BeneficiaryCubit>().amountTextField.text =
                                sl<BeneficiaryCubit>()
                                    .amountTextField
                                    .text
                                    .replaceAll(",", "");
                            formatAmountText(
                                sl<BeneficiaryCubit>().amountTextField);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 7),
                            child: Icon(
                              CupertinoIcons.delete_left_fill,
                              color: Color(0xff8B969A),
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: LoadingButton(
                    topPadding: 10,
                    title: buttonTitle,
                    onTap: () async {
                      sl<TransactionAmountCubit>().onAmountChange(
                          sl<BeneficiaryCubit>().amountTextField.text);
                      sl<BeneficiaryCubit>().updateBeneficiary(beneficiary);
                    },
                    isLoading: state is BeneficiaryUpdateLoadingState),
              ),
            ],
          );
        },
      ),
    );
  }

  void formatAmountText(TextEditingController editingController) {
    if (editingController.text.isNotEmpty && editingController.text[0] == '0') {
      editingController.text = '';
    }
    editingController.text = editingController.text.removeNonNumber;
    editingController.text = editingController.text.amountFormatter;

    ///action callback
    editingController.selection = TextSelection.fromPosition(
        TextPosition(offset: editingController.text.length));
  }
}
