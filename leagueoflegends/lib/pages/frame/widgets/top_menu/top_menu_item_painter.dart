import 'dart:ui';

import 'package:flutter/material.dart' hide Gradient;

class TopMenuItemPainter extends CustomPainter {
  TopMenuItemPainter(
    this.mouseX, {
    required this.enter,
  });

  bool enter;

  // 鼠标的坐标点
  double mouseX;

  @override
  void paint(Canvas canvas, Size size) {
    /// 没有进入不需要绘制
    if (!enter) {
      return;
    }
    var gradient = Gradient.radial(
      Offset(mouseX, 102),
      size.width,
      [
        const Color(0xFF91887e),
        const Color(0xCC91887e),
        const Color(0x3391887e),

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
        mouseX - ovalWidth / 2,
        size.height / 2 + 10,
        ovalWidth,
        ovalWidth,
      ),
      paint,
    );

    // 绘制金线
    // 计算金线的开始位置 鼠标的X坐标 减去 画刷宽度的一半
    Gradient lineColor = Gradient.linear(
      Offset(mouseX - 40, size.height),
      Offset(mouseX + 40, size.height),
      [
        Colors.transparent,
        const Color(0X38e2d7bf),
        const Color(0XFFe2d7bf),
        const Color(0X38e2d7bf),
        Colors.transparent,
      ],
      [0, .25, .5, .75, 1],
    );

    canvas.drawLine(
      Offset(mouseX - 40, size.height),
      Offset(mouseX + 40, size.height),
      Paint()
        ..color = const Color(0xFFe6dbc3)
        ..strokeCap = StrokeCap.round
        ..shader = lineColor
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant TopMenuItemPainter oldDelegate) {
    return enter != oldDelegate.enter || mouseX != oldDelegate.mouseX;
  }
}
