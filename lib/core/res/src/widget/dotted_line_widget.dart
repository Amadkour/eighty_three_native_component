import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/material.dart';

class DashedLineVerticalPainter extends CustomPainter {
  final Color? color;
  final double width;
  DashedLineVerticalPainter({this.color, this.width = 1});
  @override
  void paint(Canvas canvas, Size size) {
    const double dashHeight = 5;
    const double dashSpace = 3;
    double startY = 0;
    final Paint paint = Paint()
      ..color = color ?? Colors.black
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double dashWidth = 5;
    const double dashSpace = 5;
    double startX = 0;
    final Paint paint = Paint()
      ..color = AppColors.secondaryColor.withOpacity(0.2)
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
