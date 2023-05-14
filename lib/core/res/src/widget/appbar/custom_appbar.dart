import 'package:auto_size_text/auto_size_text.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/custom_back_button.dart';
import 'package:eighty_three_native_component/core/res/theme/font_styles.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Color? backgroundColor;
  final bool showShadow;
  final bool closeButton;
  final VoidCallback? closeButtonCallBack;
  final VoidCallback? onBack;
  final Widget? actions;
  final bool showBackButton;
  final bool showActions;
  final Widget? bottomWidget;
  final int? numberNotifications;
  final double? height;

  const MainAppBar({
    super.key,
    this.title,
    this.bottomWidget,
    this.backgroundColor,
    this.showShadow = false,
    this.closeButton = false,
    this.showBackButton = true,
    this.showActions = false,
    this.closeButtonCallBack,
    this.onBack,
    this.numberNotifications,
    this.actions,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: PreferredSize(
        preferredSize: size,
        child: height == 0
            ? const SizedBox()
            : Material(
                color: backgroundColor ?? Colors.white,
                child: Container(
                  height: height ?? size.height,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: backgroundColor ?? Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                    boxShadow: <BoxShadow>[
                      if (showShadow)
                        BoxShadow(
                          color: colorScheme.shadow.withOpacity(0.25),
                          spreadRadius: 5,
                          blurRadius: 5,
                        )
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                if (showBackButton) ...<Widget>[
                                  CustomBackButton(
                                      key: const Key("back_button"),
                                      onBack: onBack ??
                                          () => CustomNavigator.instance.pop()),
                                ],
                                if (title != null)
                                  Expanded(
                                    child: AutoSizeText(
                                      tr(title!),
                                      minFontSize: 8,
                                      maxFontSize: 16,
                                      style: appBarStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (actions != null) ...<Widget>[actions!]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  static const Size size = Size.fromHeight(110);

  @override
  Size get preferredSize => size;
}
