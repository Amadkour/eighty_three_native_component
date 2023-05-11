import 'package:flutter/cupertino.dart';

class FocusNodeModel {
  final FocusNode focusNode;
  final VoidCallback? onTap;

  FocusNodeModel({required this.focusNode, this.onTap});
}
