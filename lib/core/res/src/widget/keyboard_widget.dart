import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/child/account_num_text_field.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardWidget extends StatelessWidget {
  KeyboardWidget({super.key, required this.controller, this.maxLength = 7});
  final List<String> numberList = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  final TextEditingController controller;
  final int maxLength;

  final MaskedTextInputFormatter maskFormatter =
      MaskedTextInputFormatter(mask: '00,000', separator: ',');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: AnimatedContainer(
          padding: const EdgeInsets.only(top: 30, right: 40, left: 40),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          duration: const Duration(seconds: 2),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.25,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              ...List<Widget>.generate(
                numberList.length,
                (int index) {
                  return InkWell(
                    key: Key("pin_code_${numberList[index]}"),
                    onTap: () {
                      _addText(numberList[index]);
                    },
                    child: Text(
                      tr(numberList[index]),
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 32,
                          fontFamily: 'Plain',
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                  onTap: () {
                    _addText('00');
                  },
                  child: Text(
                    tr('00'),
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
                  onTap: () {
                    _addText('0');
                  },
                  child: Text(
                    tr('0'),
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
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      controller.text = controller.text
                          .substring(0, controller.text.length - 1);
                    }
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
        ));
  }

  void _addText(String char) {
    if (controller.text.length < maxLength) {
      final String newText = controller.text + char;
      controller.value = maskFormatter.formatEditUpdate(
          controller.value, TextEditingValue(text: newText));
    }
  }
}
