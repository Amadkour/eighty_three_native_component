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
        scaffold: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyImage.svgAssets(
                url: 'assets/icons/about_logo.svg',
                color: CupertinoColors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Secure Mode',
                style: TextStyle(color: CupertinoColors.white, fontFamily: 'Bold', fontSize: 18),
              ),
            ],
          ),
        ));
  }
}
