import 'package:eighty_three_native_component/core/res/src/constant/widget_keys.dart';

import 'package:eighty_three_native_component/core/res/src/routes/routes_name.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/button/loading_button.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/res/theme/font_styles.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class TransferSuccessDialog {
  static final TransferSuccessDialog _instance =
  TransferSuccessDialog._internal();

  static TransferSuccessDialog get instance => _instance;

  TransferSuccessDialog._internal();

  Future<void> show(BuildContext context,
      {String type = "transfer", required List<ReceiptModel> receiptModel,bool isMultipleReceipt=false,String? executionAt}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.secondaryColor,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: context.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MyImage.svgAssets(
                    url: "assets/icons/transfer/success_transfer.svg",
                    width: 240,
                    height: 165,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 29),
                    child: Text(
                      tr("transfer_successful"),
                      style: headlineStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    tr("payment_transfer_success"),
                    style: descriptionStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 12),
                    child: LoadingButton(
                      key: viewEReceiptKey,
                      isLoading: false,
                      onTap: () {
                        CustomNavigator.instance.pop();
                        CustomNavigator.instance.push(
                          routeWidget: TransactionReceiptPage(
                            executionAt:executionAt ,
                            isMultipleReceipt: isMultipleReceipt,
                            // card: receiptModel?.cardModel,
                            // to: receiptModel?.beneficiary,
                            // amount: sl<TransactionAmountCubit>().amount.toString(),
                            transactionTitle: 'transfer',
                            receiptModels: receiptModel,
                          ),
                        );
                      },
                      title: tr("view_e_receipt"),
                    ),
                  ),
                  TextButton(
                    key: cancelButtonDialogKey,
                    onPressed: () {
                      CustomNavigator.instance.popUntil(
                              (Route<dynamic> route) =>
                          route.settings.name ==
                              RoutesName.authDashboard);
                    },
                    child: Text(
                      tr("back_to_home"),
                      style: paragraphStyle.copyWith(
                        color: AppColors.blueColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
