import 'dart:ui';

import 'package:flutter/material.dart' hide Gradient;

class TopMenuItemPainter extends CustomPainter {
  TopMenuItemPainter(
    this.center, {
    required this.enter,
  });

  bool enter;

  // 中简 点
  double center;

  @override
  void paint(Canvas canvas, Size size) {
    /// 没有进入不需要绘制
    if (!enter) {
      return;
    }
    var gradient = Gradient.radial(
      Offset(center, size.height + 20),
      size.width,
      [
        const Color(0xFF91887e),
        const Color(0xAA91887e),
        const Color(0x0091887e),

        //Colors.red, Colors.red.shade500, Colors.red.shade100,
      ],
      [
        0,
        0.6,
        1,
      ],
    );

    var paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30)
      ..strokeWidth = 1;

    // 设置裁剪区域，超出该区域不会绘制
    canvas.clipRect(Offset.zero & size);

    double ovalWidth = 80;

    canvas.drawOval(
      Rect.fromLTWH(
          center - ovalWidth / 2, size.height / 2 + 20, ovalWidth, ovalWidth),
      paint,
    );

    canvas.drawLine(
      Offset(center - 20, size.height),
      Offset(center + 20, size.height),
      Paint()
        ..color = const Color(0xFFe6dbc3)
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant TopMenuItemPainter oldDelegate) {
    return enter != oldDelegate.enter || center != oldDelegate.center;
  }
}
