import 'package:eighty_three_native_component/core/res/src/widget/base_page.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/cupertino.dart';

class BackgroundPage extends StatelessWidget {
  const BackgroundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        backgroundColor: AppColors.primaryColor,
        scaffold: Column(
          children: [
            MyImage.assets(url: ''),
            const Text('Secure Mode'),
          ],
        ));
  }
}
