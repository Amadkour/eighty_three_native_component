import 'package:auto_size_text/auto_size_text.dart';
import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';

import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/src/loading.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/res/theme/decoration_values.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropDownListWithValidator extends StatelessWidget {
  final dynamic textValue;
  final List<DropdownMenuItem<dynamic>> list;
  final bool isFlagExist;
  final String? itemToString;
  final void Function(dynamic) onChanged;
  final Color color;
  final bool canChange;
  final Color? backgroundColor;
  final String? hintText;
  final String? defaultSvgImage;
  final bool isLoading;
  final String? itemIcon;

  const CustomDropDownListWithValidator(
      {super.key,
      required this.onChanged,
      required this.color,
      this.itemIcon,
      this.canChange = true,
      this.hintText,
      this.itemToString,
      this.defaultSvgImage = "assets/flags/saudi_arabia.svg",
      required this.textValue,
      required this.list,
      this.isFlagExist = false,
      this.backgroundColor,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: defaultBorderRadius,
      ),
      child: isLoading
          ? const Center(
              child: NativeLoading(),
            )
          : DropdownButtonFormField<dynamic>(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              hint: AutoSizeText(hintText ?? tr("Choose item"),
                  style: TextStyle(
                    color: AppColors.hintTextColor,
                    fontSize: 12,
                    fontFamily: 'semiBold',
                    fontWeight: FontWeight.w400,
                  ),
                  minFontSize: 8,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              selectedItemBuilder: (BuildContext context) => list
                  .map((DropdownMenuItem<dynamic> e) => Container(
                      alignment: currentUserPermission.isArabic
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          if (isFlagExist)
                            Padding(
                              padding: EdgeInsets.only(
                                  right: !currentUserPermission.isArabic ? 7 : 0,
                                  left: !currentUserPermission.isArabic ? 0 : 7),
                              child: ClipOval(
                                child: itemIcon != null
                                    ? SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          child: SvgPicture.network(
                                            itemIcon!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : MyImage.svgAssets(
                                        url: defaultSvgImage,
                                        height: 22,
                                        width: 22,
                                      ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          Expanded(
                              child: AutoSizeText(itemToString!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ))),
                        ],
                      )))
                  .toList(),
              items: list,
              validator: (dynamic value) {
                if (value == null) {
                  return tr("Please Choose item");
                } else {
                  return null;
                }
              },
              onChanged: canChange ? onChanged : null,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding:
                    const EdgeInsets.only(top: 5, left: 8, right: 8),
                hintText: tr("Choose item"),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                border: InputBorder.none,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              isExpanded: true,
              icon: MyImage.svgAssets(
                url: "assets/icons/transfer/dropdownarrow.svg",
                height: 8,
                width: 8,
              ),
              value: textValue,
            ),
    );
  }
}
