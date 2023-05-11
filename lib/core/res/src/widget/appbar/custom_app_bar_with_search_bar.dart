import 'package:eighty_three_native_component/core/res/src/provider/model/logged_in_user_model.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/history_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBarWithSearchBar extends StatelessWidget {
  const CustomAppBarWithSearchBar(
      {super.key,
      this.hintText,
      this.actions,
      required this.onChanged,
      required this.controller,
      required this.onClear});
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final TextEditingController controller;
  final String? hintText;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: InkWell(
        onTap: () => CustomNavigator.instance.pop(),
        child: Container(
            margin: const EdgeInsets.all(18),
            child: !(loggedInUser.locale == 'ar')
                ? SvgPicture.asset("assets/icons/back.svg")
                : RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset("assets/icons/back.svg"))),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: SearchBar(
          onClear: onClear,
          showClear: controller.text.isEmpty,
          hintText: hintText ?? "Search name or address",
          onChanged: onChanged,
          controller: controller),
      actions: actions ??
          const <Widget>[
            HistoryIconWidget(),
            SizedBox(
              width: 20,
            )
          ],
    );
  }
}
