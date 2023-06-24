import 'package:eighty_three_native_component/core/res/src/constant/shared_orefrences_keys.dart';
import 'package:eighty_three_native_component/core/res/src/services/base_controller.dart';
import 'package:flutter/material.dart';

class CustomNavigator {
  CustomNavigator._singleTone();
  String currentScreenName="";

  static final CustomNavigator _instance = CustomNavigator._singleTone();

  static CustomNavigator get instance => _instance;

  Future<void> pop({int numberOfPop = 1, dynamic result,BaseController? nextController}) async {
    nextController?.stopLoading();
    for (int i = 0; i < numberOfPop; i++) {
      Navigator.pop(globalKey.currentContext!, result);
    }
  }

  void popWithoutAnimation({int numberOfPop = 1, required Widget routeWidget,
    BaseController?popAnimationController}) {
    popAnimationController?.stopLoading();
    for (int i = 0; i < numberOfPop; i++) {
      Navigator.pop(
          globalKey.currentContext!,
          PageRouteBuilder<dynamic>(
            pageBuilder: (BuildContext context, Animation<double> animation1,
                    Animation<double> animation2) =>
                routeWidget,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ));
    }
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments,BaseController? previousController})
  async {
      previousController?.stopLoading();
    currentScreenName = routeName;
    return Navigator.pushNamed(globalKey.currentContext!, routeName,
        arguments: arguments);
  }

  void pushNamedAndRemoveUntil(
      String routeName, bool Function(Route<dynamic> route) callback,
      {Object? arguments,BaseController? previousAndRemoveUntilController}) {
    previousAndRemoveUntilController?.stopLoading();
    currentScreenName = routeName;
    Navigator.pushNamedAndRemoveUntil(
        globalKey.currentContext!, routeName, callback,
        arguments: arguments);
  }

  void pushAndRemoveUntil({
    required Widget routeWidget,
    required bool Function(Route<dynamic> route) callback,BaseController? previousAndRemoveController
  }) {
    previousAndRemoveController?.stopLoading();
    Navigator.pushAndRemoveUntil(
      globalKey.currentContext!,
      MaterialPageRoute<dynamic>(builder: (_) => routeWidget),
      callback,
    );
  }

  void popAndPushNamed({required String routeName, Object? argument,BaseController?
  popAndPushController}) {
    popAndPushController?.stopLoading();
    currentScreenName = routeName;
    Navigator.popAndPushNamed(globalKey.currentContext!, routeName,
        arguments: argument);
  }

  Future<void> pushReplacementNamed(String routeName,
      {Object? argument,BaseController? previousReplacementController}) async {
    previousReplacementController?.stopLoading();
    currentScreenName = routeName;
    await Navigator.pushReplacementNamed(globalKey.currentContext!, routeName,
        arguments: argument);
  }

  Future<T?> push<T>({
    required Widget routeWidget,BaseController? pushController
  }) {
    pushController?.stopLoading();
    return Navigator.push<T>(
      globalKey.currentContext!,
      MaterialPageRoute<T>(builder: (_) => routeWidget),
    );
  }

  void maybePop({BaseController? maybePopController}) {
    maybePopController?.stopLoading();
    Navigator.maybePop(globalKey.currentContext!);
  }

  void popUntil(bool Function(Route<dynamic> route) callback,BaseController? popUntilController) {
   popUntilController?.stopLoading();
    Navigator.popUntil(globalKey.currentContext!, callback);
  }

  void pushReplacementWithoutAnimations({
    required Widget routeWidget,BaseController?  pushReplacementWithoutAnimationsController
  }) {
    pushReplacementWithoutAnimationsController?.stopLoading();
    Navigator.pushReplacement(
        globalKey.currentContext!,
        PageRouteBuilder<dynamic>(
          pageBuilder: (BuildContext context, Animation<double> animation1,
                  Animation<double> animation2) =>
              routeWidget,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
  }
}
