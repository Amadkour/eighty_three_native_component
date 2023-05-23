import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';


class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final bool showClear;
  final void Function()? onTab;
  final String? searchIconPath;
  final double verticalPadding;
  final Color? backGroundColor;

  const CustomSearchBar(
      {super.key,
        this.verticalPadding = 10,
        this.backGroundColor,
        this.showClear = false,
        required this.hintText,
        required this.onChanged,
        this.onClear,
        this.controller,
        this.searchIconPath,
        this.onTab});

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      controller: controller,
      onChanged: onChanged,
      verticalPadding: verticalPadding,
      onTab: onTab,
      fillColor: backGroundColor ?? AppColors.lightWhite,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          showClear
              ? MyImage.svgAssets(
            width: 17,
            height: 17,
            url: searchIconPath ?? "assets/icons/transfer/searchicon.svg",
          )
              : InkWell(
              onTap: () {
                onClear?.call();
              },
              child: const Icon(
                Icons.close_sharp,
                color: Colors.grey,
                size: 20,
              )),
          const SizedBox(
            width: 11,
          )
        ],
      ),
      hintStyle: TextStyle(
          fontSize: 13,
          color: AppColors.grayTextColor,
          fontWeight: FontWeight.w300),
      hint: tr(hintText),
      borderRadius: 7,
    );
  }
}
