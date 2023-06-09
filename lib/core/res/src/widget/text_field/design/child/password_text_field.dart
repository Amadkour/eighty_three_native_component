import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'package:password_policy/password_policy.dart';

class PasswordTextField extends StatelessWidget {
  final FocusNode? passwordFocusNode;

  final bool securePasswordText;
  final void Function() changePasswordSecureTextState;

  final String? passTitle;
  final String? passHint;
  final String? error;
  final double? fullWidth;
  final double? titleFontSize;
  final TextEditingController? controller;
  final void Function()? onTab;
  final void Function(String?) onChanged;
  final Widget? prefix;
  final bool hasPrefix;

  const PasswordTextField({
    super.key,
    this.passwordFocusNode,
    required this.securePasswordText,
    required this.changePasswordSecureTextState,
    this.titleFontSize,
    this.error,
    this.passTitle = '',
    this.passHint = '',
    this.fullWidth,
    this.onTab,
    required this.onChanged,
    this.controller,
    this.prefix,
    this.hasPrefix = false,
  });

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
        prefix: hasPrefix
            ? prefix ??
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.lock_outline,
                    size: 30,
                  ),
                )
            : null,
        isPassword: securePasswordText,
        error: error,
        titleFontSize: titleFontSize,
        controller: controller,
        onChanged: (String? value) {
          onChanged(value);
        },
        onTab: onTab,
        suffix: IconButton(
            key: const Key("show_password_button"),
            icon: Icon(
              securePasswordText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: AppColors.darkColor,
              size: 20,
            ),
            splashRadius: 1,
            onPressed: changePasswordSecureTextState),
        hintFontSize: fullWidth == null ? null : fullWidth! / 30,
        title: tr(passTitle!),
        hint: tr(passHint!),
        validator: (String? value) {
          PasswordPolicy passwordPolicy = PasswordPolicy(
            validationRules: [
              LengthRule(minimalLength: 8,name:tr('min_length')),
              UpperCaseRule(isMandatory: true,name: tr('upper_case')),
              LowerCaseRule(isMandatory: true,name: tr('lower_case')),
              SpecialCharacterRule(isMandatory: true,name: tr('special_char')),
              DigitRule(isMandatory: true,name:tr('digit_rule')),
              // ask to not use spaces (including tabs, newlines, etc)
              NoSpaceRule(isMandatory: false),
            ],
          );

          PasswordCheck passwordCheck = PasswordCheck(password:value??'', passwordPolicy: passwordPolicy);

          // errorMessage("Password score: ${passwordCheck.score}");
          // errorMessage("Password strength: ${passwordCheck.strength.name}");
          if (passwordCheck.isValid) {
            return null;
          }else {
            return passwordCheck.notRespectedMandatoryRules
                .map<String?>((rule) => rule.name)
                .join("\n");

          }
        },
        focusNode: passwordFocusNode);
  }
}
