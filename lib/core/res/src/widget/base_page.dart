import 'package:eighty_three_native_component/core/res/src/configuration/top_level_configuration.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/global_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/routes/routes_name.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';

import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/background_page.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../permissions/permission.dart';

class MainScaffold extends StatelessWidget with WidgetsBindingObserver {
  final Widget scaffold;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBarWidget;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;

  MainScaffold({
    super.key,
    required this.scaffold,
    this.floatingActionButton,
    this.appBarWidget,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.extendBodyBehindAppBar = false,
    this.backgroundColor,
  }) {
    WidgetsBinding.instance.addObserver(this);
  }

  final globalCubit = sl<GlobalCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalCubit>.value(
      value: globalCubit,
      child: Builder(builder: (BuildContext context) {
        return BlocBuilder<GlobalCubit, GlobalState>(
          builder: (BuildContext context, GlobalState state) {
            return Directionality(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: Material(
                child: InkWell(
                  overlayColor: MaterialStateProperty.all(AppColors.lightWhite),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Scaffold(
                    bottomNavigationBar: bottomNavigationBar,
                    extendBodyBehindAppBar: extendBodyBehindAppBar,
                    floatingActionButton: floatingActionButton,
                    resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
                    appBar: appBarWidget,
                    body: scaffold,
                    backgroundColor: backgroundColor,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  static DateTime _backgroundTime = DateTime.now();
  static AppLifecycleState? _state;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_state != state) {
      _state = state;

      ///secure Screen
      if (state == AppLifecycleState.inactive) {
        CustomNavigator.instance
            .pushWithoutAnimations(routeWidget: const BackgroundPage(), name: 'background_page');
      }

      ///secure Screen

      ///--------------foreground
      if (state == AppLifecycleState.resumed) {
        CustomNavigator.instance.popUntil((route) => route.settings.name != 'background_page');

        /// To ensure login
        if ((currentUserPermission.token ?? "").isNotEmpty &&

                /// To ensure threshold 25s
                DateTime.now().difference(_backgroundTime).inSeconds > 25 &&

                /// To ensure secureCode configuration
                (currentUserPermission.pinCode ?? "").isNotEmpty &&
                haveLocalAuth

            /// To ensure in non configuration page
            ) {
          if (type != 'integration test') {
            CustomNavigator.instance.pushNamed(RoutesName.pinCodeWithoutAnimation);
          }
        }

        ///--------------background
        _backgroundTime = DateTime.now();
      } else if (state == AppLifecycleState.paused) {
        _backgroundTime = DateTime.now();
      }
      super.didChangeAppLifecycleState(state);
    }
  }
}

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState);

  bool canRefresh = false;

  Future onRefresh();
}
