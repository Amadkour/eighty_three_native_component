import 'package:flutter/material.dart';

VoidCallback dismissKeyboard(BuildContext context) {
  return () {
    FocusScope.of(context).unfocus();
  };
}

bool toBool(Object? input) {
  return input == true || input == 1 || input == '1';
}
