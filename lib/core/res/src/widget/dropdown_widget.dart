import 'package:auto_size_text/auto_size_text.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/core/res/theme/font_styles.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'images/my_image.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? itemToString;
  final String? label;
  final Widget? addIcon;
  final FocusNode? focusNode;
  final Widget Function(T item)? itemBuilder;
  final String? hintText;
  final String? iconPath;
  final Widget? leading;
  final Color? color;
  final bool hasClearButton;
  final VoidCallback? onClear;
  final Key? clearButtonKey;
  final Color borderColor;

  const CustomDropdown({
    super.key,
    required this.items,
    this.onChanged,
    this.itemToString,
    this.label,
    this.iconPath,
    this.value,
    this.leading,
    this.color,
    this.hasClearButton = false,
    this.onClear,
    this.clearButtonKey,
    this.borderColor = Colors.transparent,
    this.hintText,
    this.addIcon,
    this.itemBuilder,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      if (label != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Text(
                tr(label!),
                style: descriptionStyle.copyWith(
                  color: Colors.black,
                ),
              ),
              if (addIcon != null) addIcon!,
            ],
          ),
        ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
            color: color ?? AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
            )),
        child: DropdownButtonFormField<T>(
          items: items.map((T e) {
            return DropdownMenuItem<T>(
              value: e,
              child: itemBuilder != null
                  ? itemBuilder!(e)
                  : Text(
                      (e != null) ? itemToString?.call(e) ?? "$e" : "",
                      style: textTheme.titleMedium,
                    ),
            );
          }).toList(),
          focusNode: focusNode,
          onChanged: onChanged,
          isExpanded: true,
          hint: AutoSizeText(
            hintText ?? tr("Choose item"),
            style: TextStyle(
              color: AppColors.hintTextColor,
              fontSize: 12,
              fontFamily: 'semiBold',
              fontWeight: FontWeight.w400,
            ),
          ),
          icon: Row(
            children: <Widget>[
              MyImage.svgAssets(
                url: iconPath??"assets/icons/transfer/dropdownarrow.svg",
                height: 4.5,
                width: 8,
              ),
              if (hasClearButton)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: InkWell(
                    key: clearButtonKey,
                    onTap: () {
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
          decoration: const InputDecoration(border: InputBorder.none),
          value: value,
          menuMaxHeight: 300,
        ),
      )
    ]);
  }
}
