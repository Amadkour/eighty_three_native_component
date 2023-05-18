import 'package:eighty_three_native_component/core/res/src/provider/api/api_connection.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/alternative_widgets/error_widget.dart';
import 'package:eighty_three_native_component/core/res/src/widget/base_page.dart';
import 'package:eighty_three_native_component/core/res/src/widget/button/loading_button.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkErrorPage extends StatelessWidget {
  const NetworkErrorPage({super.key, required this.callback});

  final Future<void> Function() callback;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: Scaffold(
          body: MyErrorWidget(
            message: '',
            image: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const Icon(
                    CupertinoIcons.wifi_slash,
                    size: 50,
                  ),
                  const Text(
                    'NETWORK ERROR',
                  ),
                  LoadingButton(
                    isLoading: false,
                    hasBottomSaveArea: false,
                    title: 'reload',
                    onTap: () async {
                      sl<APIConnection>().networkError = false;

                      CustomNavigator.instance.pop();
                      await callback();
                    },
                  ),
                  LoadingButton(
                    topPadding: 0,
                    hasBottomSaveArea: false,
                    backgroundColor: Colors.white,
                    fontColor: AppColors.blackColor,
                    isLoading: false,
                    title: 'Ignore This Error',
                    onTap: () async {
                      CustomNavigator.instance.pop();
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
