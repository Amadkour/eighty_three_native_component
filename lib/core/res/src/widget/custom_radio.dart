import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:flutter/material.dart';

class CustomRadio<T> extends StatelessWidget {
  const CustomRadio(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged});

  final T value;
  final T groupValue;
  final void Function(T? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Radio<T>(
      value: value!,
      groupValue: groupValue,
      onChanged: onChanged,
      fillColor: MaterialStateProperty.all<Color>(
        context.theme.primaryColor,
      ),
    );
  }
}
