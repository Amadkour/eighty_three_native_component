import 'package:eighty_three_native_component/core/res/src/widget/base_page.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/cupertino.dart';

class BackgroundPage extends StatelessWidget {
  const BackgroundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        backgroundColor: const Color(0xff4EC89E),
        scaffold: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyImage.assets(url: 'assets/images/store/appstore.png'),
            const SizedBox(height: 20,),
            const Text('Secure Mode'),
          ],
        ));
  }
}
