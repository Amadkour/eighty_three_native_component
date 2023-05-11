import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool value)? onChanged;

  const CustomSwitch({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      trackColor:
          MaterialStateProperty.all(const Color(0xff00FF12).withOpacity(0.2)),
      activeColor: const Color(0xff4EC89E),
      onChanged: onChanged,
    );
  }
}
