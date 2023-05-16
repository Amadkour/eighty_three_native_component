import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ComingSoon extends StatelessWidget {
  final String? message;
  final bool showMessage;
  final double? height;

  const ComingSoon({super.key, this.message, this.showMessage = true, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: (height ?? 200) / 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const FaIcon(FontAwesomeIcons.bullhorn),
            const SizedBox(
              height: 15,
            ),
            Text(
              message ?? tr('coming_soon'),
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: 'Bold',
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
