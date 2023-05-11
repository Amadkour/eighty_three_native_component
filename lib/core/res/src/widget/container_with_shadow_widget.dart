import 'package:flutter/material.dart';

class ContainerWithShadow extends StatelessWidget {
  const ContainerWithShadow({
    super.key,
    this.padding,
    this.margin,
    required this.child,
    this.width,
  });
  final EdgeInsets? padding;
  final EdgeInsetsGeometry? margin;
  final Widget child;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ?? double.infinity,
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const <BoxShadow>[
        BoxShadow(
          offset: Offset(0, 8),
          blurRadius: 33,
          color: Color.fromRGBO(38, 38, 38, 0.1),
        )
      ]),
      padding: padding,
      child: child,
    );
  }
}
