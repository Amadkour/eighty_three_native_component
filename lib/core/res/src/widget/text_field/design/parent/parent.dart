import 'package:eighty_three_native_component/core/res/src/cubit/global_cubit.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParentTextField extends StatelessWidget {
  final GestureTapCallback? onTab;
  final TextEditingController? controller;
  final String? name;
  final bool enableCopy;
  final bool autoFocus;
  final String? titleFontFamily;
  final List<TextInputFormatter>? textInputFormatter;
  final double? hintFontSize;
  final Color? fillColor;
  final Color? borderColor;
  final String? error;
  final TextStyle? hintStyle;
  final Color labelColor;
  final int multiLine;
  final String? title;
  final Widget? suffix;
  final Widget? prefix;
  final double padding;
  final double verticalPadding;
  final double? titleFontSize;
  final InputBorder? border;
  final double? height;
  final double? width;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final FocusNode? focusNode;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final bool emitTextFieldChange;
  final TextInputType? keyboardType;
  final bool? custom;
  final InputDecoration? decoration;
  final TextStyle? style;
  final double? borderRadius;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final String? hint;
  final String? defaultValue;
  final String? prefixText;
  final Color? titleFontColor;
  final TextAlign textAlign;
  final double cursorWidth;
  final int? maxLength;

  const ParentTextField({
    this.controller,
    this.keyboardType,
    this.name,
    this.custom,
    this.hintStyle,
    this.hintFontSize = 12,
    this.fillColor,
    this.borderColor,
    this.validator,
    super.key,
    this.padding = 20.0,
    this.verticalPadding = 20.0,
    this.titleFontSize,
    this.multiLine = 1,
    this.textInputAction,
    this.labelColor = const Color(0xff011E06),
    this.title,
    this.suffix,
    this.hint,
    this.prefix,
    this.error,
    this.border,
    this.height,
    this.width,
    this.readOnly = false,
    this.focusNode,
    this.isPassword = false,
    this.emitTextFieldChange = true,
    this.onTab,
    this.onChanged,
    this.decoration,
    this.style,
    this.borderRadius,
    this.titleFontFamily,
    this.defaultValue,
    this.textAlign = TextAlign.start,
    this.textInputFormatter,
    this.onSubmitted,
    this.cursorWidth = 2.0,
    this.maxLength,
    this.enableCopy = true,
    this.autoFocus = false,
    this.prefixText,
    this.titleFontColor,
  });

  @override
  Widget build(BuildContext context) {
    String? err = error;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null)
          Text(
            title!,
            style: TextStyle(
                fontSize: titleFontSize,
                color: titleFontColor ?? AppColors.blackColor,
                fontFamily: titleFontFamily,
                fontWeight: FontWeight.w500),
          ),
        if (title != null)
          const SizedBox(
            height: 5,
          ),
        Directionality(
          textDirection: (!isArabic || keyboardType == TextInputType.number)
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: TextFormField(
            //enabled: !readOnly,
            enableInteractiveSelection: enableCopy,
            autofocus: autoFocus,
            onFieldSubmitted: onSubmitted,
            cursorColor: Colors.black,
            cursorWidth: cursorWidth,
            scrollPadding: EdgeInsets.symmetric(vertical: verticalPadding),
            minLines: multiLine,
            maxLines: multiLine,
            focusNode: focusNode,
            readOnly: readOnly,
            controller: controller,
            validator: validator,
            inputFormatters: textInputFormatter ??
                (<TextInputFormatter>[
                  if (keyboardType == TextInputType.number ||
                      keyboardType == TextInputType.phone)
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  if (maxLength != null)
                    LengthLimitingTextInputFormatter(maxLength)
                ]),

            obscureText: isPassword,
            textAlign: textAlign,
            textInputAction: textInputAction ??
                (multiLine > 1 ? TextInputAction.done : TextInputAction.next),
            keyboardType: keyboardType,
            style: style ??
                const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400),
            textAlignVertical: TextAlignVertical.center,
            autovalidateMode: AutovalidateMode.onUserInteraction,

            onChanged: (String val) {
              err = '';
              onChanged?.call(val);
              // sl.get<GlobalCubit>().changeTextField();
            },
            initialValue: defaultValue,
            onTap: onTab,
            decoration: decoration ??
                InputDecoration(
                  prefixText: prefixText,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        borderRadius ?? 10.0,
                      ),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        borderRadius ?? 10.0,
                      ),
                    ),
                  ),
                  errorText: err == '' || err == null ? null : err,
                  errorStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: err == null ? 0 : null,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: padding,
                    vertical: verticalPadding,
                  ),
                  fillColor: fillColor ?? Colors.white,
                  filled: true,
                  focusColor: Theme.of(context).primaryColor,
                  hintText: hint,
                  errorMaxLines: 2,
                  hintMaxLines: 1,
                  prefixIcon: prefix,
                  alignLabelWithHint: true,
                  // custom != null ? title : null,
                  suffixIcon: suffix,
                  labelStyle: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Plain',
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor),
                  hintStyle: hintStyle ??
                      TextStyle(
                        color: AppColors.hintTextColor,
                        fontSize: hintFontSize ?? 12,
                        fontFamily: 'semiBold',
                        fontWeight: FontWeight.w400,
                      ),
                  border: border ??
                      OutlineInputBorder(
                        borderSide: BorderSide(
                            color: borderColor ?? Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            borderRadius ?? 10.0,
                          ),
                        ),
                      ),
                  disabledBorder: border ??
                      OutlineInputBorder(
                        borderSide: BorderSide(
                            color: borderColor ?? Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            borderRadius ?? 10.0,
                          ),
                        ),
                      ),
                ),
          ),
        ),
      ],
    );
  }
}
