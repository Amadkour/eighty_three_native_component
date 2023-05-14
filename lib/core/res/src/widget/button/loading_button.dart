import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {
  final VoidCallback? onTap;
  final String? titleButton;
  final BuildContext context;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? disableColor;
  final Color? fontColor;
  final Color? loaderColor;
  final bool enable;
  final FontWeight? fontWeight;
  final double? height;
  final bool hasBottomSaveArea;
  final double? borderRadius;

  StaggerAnimation({
    super.key,
    required this.buttonController,
    this.onTap,
    this.titleButton,
    required this.context,
    this.backgroundColor,
    this.loaderColor,
    this.borderColor,
    this.fontColor,
    required this.enable,
    this.disableColor,
    this.fontWeight,
    this.height,
    this.borderRadius,
    this.hasBottomSaveArea = true,
  })  : buttonSqueezeAnimation = Tween<double>(
          begin: MediaQuery.of(context).size.width,
          end: 50.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: const Interval(
              0.0,
              0.150,
            ),
          ),
        ),
        containerCircleAnimation = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 30.0),
          end: EdgeInsets.zero,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: const Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        );

  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation<double> buttonSqueezeAnimation;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return InkWell(
      onTap: enable && buttonController.status != AnimationStatus.forward
          ? onTap
          : null,
      child: Container(
        width: buttonSqueezeAnimation.value,
        height: height,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          color: enable
              ? (backgroundColor ?? AppColors.blackColor)
              : (disableColor ??
                  (backgroundColor ?? AppColors.blackColor).withOpacity(0.12)),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 7.0)),
        ),
        child: buttonSqueezeAnimation.value > 75.0
            ? Text(
                tr(titleButton!),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: fontColor ?? Colors.white,
                    fontWeight: fontWeight ?? FontWeight.w500,
                    fontFamily: 'SemiBold'),
              )
            : CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor:
                    AlwaysStoppedAnimation<Color>(loaderColor ?? Colors.white),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}

class LoadingButton extends StatefulWidget {
  const LoadingButton(
      {super.key,
      this.onTap,
      required this.isLoading,
      this.title,
      this.topPadding = 40,
      this.backgroundColor,
      this.fontColor,
      this.disableColor,
      this.loaderColor,
      this.borderColor,
      this.enable = true,
      this.fontWeight,
      this.height = 50,
      this.hasBottomSaveArea = true,
      this.borderRadius});

  final VoidCallback? onTap;
  final String? title;
  final bool isLoading;
  final bool enable;
  final double topPadding;
  final Color? backgroundColor;
  final Color? fontColor;
  final Color? loaderColor;
  final Color? disableColor;
  final Color? borderColor;
  final FontWeight? fontWeight;
  final double height;
  final bool hasBottomSaveArea;
  final double? borderRadius;

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton>
    with TickerProviderStateMixin {
  late AnimationController _loginButtonController;

  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
  }

  @override
  Future<void> dispose() async {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<void> loading() async {
    if (widget.isLoading) {
      await _loginButtonController.forward();
    } else {
      await _loginButtonController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    loading();
    return SafeArea(
      top: false,
      bottom: widget.hasBottomSaveArea,
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          SizedBox(height: widget.topPadding),
          Column(
            children: <Widget>[
              StaggerAnimation(
                key: const Key('loginSubmitButton'),
                context: context,
                height: widget.height,
                fontColor: widget.fontColor,
                loaderColor: widget.loaderColor,
                fontWeight: widget.fontWeight,
                enable: widget.enable,
                backgroundColor: widget.backgroundColor,
                disableColor: widget.disableColor,
                borderColor: widget.borderColor,
                titleButton: widget.title ?? "LOGIN",
                borderRadius: widget.borderRadius,
                buttonController:
                    _loginButtonController.view as AnimationController,
                onTap: widget.onTap ?? () {},
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
