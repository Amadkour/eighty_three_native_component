import 'package:eighty_three_native_component/core/res/src/cubit/global_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/theme/font_styles.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';

// ignore: must_be_immutable
class DateTextField extends StatelessWidget {
  late TextEditingController dateController;
  late String dateControllerError;
  FocusNode? focusNode;
  late bool fromSupAccount;
  String? dateTitle;
  VoidCallback? onTab;
  String? dateHint;
  bool? readOnly;
  Color? color;
  late bool hasClearButton;
  VoidCallback? onClear;
  Key? clearButtonKey;
  Key? textFieldKey;
  void Function()? onChanged;
  bool _isFilter = false;
  final String? iconPath;
  DateTextField({
    super.key,
    this.onChanged,
    required this.dateController,
    this.focusNode,
    required this.dateControllerError,
    this.clearButtonKey,
    this.onTab,
    this.textFieldKey,
    this.readOnly = false,
    this.fromSupAccount = false,
    this.dateTitle,
    this.dateHint,
    this.color,
    this.hasClearButton = false,
    this.onClear,
    this.iconPath,
  });

  DateTextField.filter({
    super.key,
    this.onClear,
    required this.dateController,
    this.clearButtonKey,
    this.textFieldKey,
    this.dateHint,
    this.dateTitle,
    this.focusNode,
    this.iconPath,
  }) {
    fromSupAccount = false;
    hasClearButton = true;
    dateControllerError = '';
    color = AppColors.backgroundColor;
    readOnly = false;
    _isFilter = true;
  }

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      key: textFieldKey,
      controller: dateController,
      onTab: onTab,
      fillColor: color,
      readOnly: readOnly!,
      keyboardType: TextInputType.none,
      hint: tr(dateHint!),
      focusNode: focusNode,
      title: tr(dateTitle!),
      error: dateControllerError,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          MyImage.svgAssets(
            url: iconPath ?? 'assets/images/registration/calendar.svg',
            key: const ValueKey<String>('register_Date_icon'),
            height: 20,
            width: 20,
            fit: BoxFit.none,
          ),
          if (hasClearButton)
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 10),
              child: InkWell(
                key: clearButtonKey,
                onTap: () {
                  dateController.text = '';
                  onClear?.call();
                },
                child: const Icon(
                  Icons.close_sharp,
                  color: Colors.grey,
                ),
              ),
            )
        ],
      ),
      validator: !_isFilter
          ? (String? value) {
        if (value != null) {
          if (DateTime.tryParse(value)?.isUnderAge() == false) {
            return null;
          } else {
            return tr('birthdate_validation');
          }
        }
        return null;
      }
          : null,
    );
  }
}

void dateSheet({
  required BuildContext context,
  required TextEditingController dateController,
  String? title,
  VoidCallback? onChanged,
  VoidCallback? onDone,
  FocusNode? focusNode,
  required bool mustAdult,
  required String dob,
}) {
  showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: MediaQuery.of(context).copyWith().size.height / 2.5,
          child: Column(
            children: <Widget>[
              Directionality(
                textDirection: title != null
                    ? isArabic
                    ? TextDirection.rtl
                    : TextDirection.ltr
                    : TextDirection.ltr,
                child: Row(
                  children: <Widget>[
                    if (title != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          title,
                          style: paragraphStyle.copyWith(
                              color: AppColors.blackColor, fontSize: 16),
                        ),
                      ),
                      const Spacer(),
                    ],
                    IconButton(
                      key: const Key("date_picked_button_key"),
                      onPressed: () {
                        if (dateController.text == '') {
                          if (mustAdult) {
                            dateController.text = intl.DateFormat('yyyy-MM-dd')
                                .format(DateTime.now().subtract(
                                const Duration(days: 6574, hours: 2)));
                          } else {
                            dateController.text = intl.DateFormat('yyyy-MM-dd')
                                .format(DateTime.now());
                          }
                        }
                        CustomNavigator.instance.pop();
                        onDone?.call();
                        focusNode?.nextFocus();
                      },
                      icon: Icon(
                        Icons.done,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  key: const Key("date_picker"),
                  initialDateTime: dateController.text == ''
                      ? DateTime.now()
                      .subtract(const Duration(days: 6574, hours: 2))
                      : DateTime.tryParse(dateController.text) != null
                      ? DateTime.parse(dateController.text)
                      : DateTime.parse(dob),
                  onDateTimeChanged: (DateTime newDate) {
                    dateController.text =
                        intl.DateFormat('yyyy-MM-dd').format(newDate);

                    onChanged?.call();
                  },
                  mode: CupertinoDatePickerMode.date,
                  dateOrder: DatePickerDateOrder.dmy,
                ),
              ),
            ],
          ),
        );
      }).whenComplete(() => focusNode?.nextFocus());
}

// class DateTextField extends StatelessWidget {
//   late TextEditingController dateController;
//   late String dateControllerError;
//   FocusNode? focusNode;
//   late bool fromSupAccount;
//   String? dateTitle;
//   VoidCallback? onTab;
//   String? dateHint;
//   bool? readOnly;
//   Color? color;
//   late bool hasClearButton;
//   VoidCallback? onClear;
//   Key? clearButtonKey;
//   Key? textFieldKey;
//   void Function()? onChanged;
//   bool _isFilter = false;
//
//   DateTextField({
//     super.key,
//     this.onChanged,
//     required this.dateController,
//     this.focusNode,
//     required this.dateControllerError,
//     this.clearButtonKey,
//     this.onTab,
//     this.textFieldKey,
//     this.readOnly = false,
//     this.fromSupAccount = false,
//     this.dateTitle,
//     this.dateHint,
//     this.color,
//     this.hasClearButton = false,
//     this.onClear,
//   });
//
//   DateTextField.filter({
//     super.key,
//     this.onClear,
//     required this.dateController,
//     this.clearButtonKey,
//     this.textFieldKey,
//     this.dateHint,
//     this.dateTitle,
//     this.focusNode,
//   }) {
//     fromSupAccount = false;
//     hasClearButton = true;
//     dateControllerError = '';
//     color = AppColors.backgroundColor;
//     readOnly = false;
//     _isFilter = true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ParentTextField(
//       key: textFieldKey,
//       controller: dateController,
//       onTab: onTab,
//       fillColor: color,
//       readOnly: readOnly!,
//       keyboardType: TextInputType.none,
//       hint: tr(dateHint!),
//       focusNode: focusNode,
//       title: tr(dateTitle!),
//       error: dateControllerError,
//       suffix: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           MyImage.svgAssets(
//             url: 'assets/images/registration/calendar.svg',
//             key: const ValueKey<String>('register_Date_icon'),
//             height: 20,
//             width: 20,
//             fit: BoxFit.none,
//           ),
//           if (hasClearButton)
//             Padding(
//               padding: const EdgeInsetsDirectional.only(start: 20, end: 10),
//               child: InkWell(
//                 key: clearButtonKey,
//                 onTap: () {
//                   dateController.text = '';
//                   onClear?.call();
//                 },
//                 child: const Icon(
//                   Icons.close_sharp,
//                   color: Colors.grey,
//                 ),
//               ),
//             )
//         ],
//       ),
//       validator: !_isFilter
//           ? (String? value) {
//               if (value != null) {
//                 if (DateTime.tryParse(value)?.isUnderAge() == false) {
//                   return null;
//                 } else {
//                   return tr('birthdate_validation');
//                 }
//               }
//               return null;
//             }
//           : null,
//     );
//   }
// }
//
// void dateSheet({
//   required BuildContext context,
//   required TextEditingController dateController,
//   String? title,
//   VoidCallback? onChanged,
//   FocusNode? focusNode,
//   required bool mustAdult,
//   required String? dob,
// }) {
//   showModalBottomSheet<void>(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.only(top: 15),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(25),
//               topRight: Radius.circular(25),
//             ),
//           ),
//           height: MediaQuery.of(context).copyWith().size.height / 2.5,
//           child: Column(
//             children: <Widget>[
//               Directionality(
//                 textDirection: title != null
//                     ? isArabic
//                         ? TextDirection.rtl
//                         : TextDirection.ltr
//                     : TextDirection.ltr,
//                 child: Row(
//                   children: <Widget>[
//                     if (title != null) ...[
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20, right: 20),
//                         child: Text(
//                           title,
//                           style: paragraphStyle.copyWith(
//                               color: AppColors.blackColor, fontSize: 16),
//                         ),
//                       ),
//                       const Spacer(),
//                     ],
//                     IconButton(
//                       key: const Key("date_picked_button_key"),
//                       onPressed: () {
//                         if (dateController.text == '') {
//                           if (mustAdult) {
//                             dateController.text = intl.DateFormat('yyyy-MM-dd')
//                                 .format(DateTime.now().subtract(
//                                     const Duration(days: 6574, hours: 2)));
//                           } else {
//                             dateController.text = intl.DateFormat('yyyy-MM-dd')
//                                 .format(DateTime.now());
//                           }
//                         }
//                         CustomNavigator.instance.pop();
//                         focusNode?.nextFocus();
//                       },
//                       icon: Icon(
//                         Icons.done,
//                         color: AppColors.blackColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: CupertinoDatePicker(
//                   key: const Key("date_picker"),
//                   initialDateTime: dateController.text == ''
//                       ? DateTime.now()
//                           .subtract(const Duration(days: 6574, hours: 2))
//                       : DateTime.tryParse(dateController.text) != null
//                           ? DateTime.parse(dateController.text)
//                           : DateTime.parse(
//                               dob!),
//                   onDateTimeChanged: (DateTime newDate) {
//                     dateController.text =
//                         intl.DateFormat('yyyy-MM-dd').format(newDate);
//
//                     onChanged?.call();
//                   },
//                   mode: CupertinoDatePickerMode.date,
//                   dateOrder: DatePickerDateOrder.dmy,
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).whenComplete(() => focusNode?.nextFocus());
// }
