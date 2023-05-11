import 'package:eighty_three_native_component/core/res/src/routes/routes_name.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/button/loading_button.dart';
import 'package:eighty_three_native_component/core/res/src/widget/dialogs/main_dialog.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class DepositDialog {
  DepositDialog() {
    MainDialog(
        icon: const Icon(Icons.warning_amber, color: Colors.orange, size: 200),
        imageHeight: 188,
        imageWidth: 260,
        dialogTitle: tr("don't_have_enough_balance"),
        bottomWidget: LoadingButton(
          isLoading: false,
          title: tr('deposit'),
          onTap: () {
            CustomNavigator.instance.pop();
            CustomNavigator.instance.pushNamed(RoutesName.newDeposit);
          },
        ),
        dialogSupTitle: tr('deposit_error'));
  }
}
