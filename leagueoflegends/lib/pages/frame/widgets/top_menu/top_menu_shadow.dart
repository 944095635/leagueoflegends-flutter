import 'dart:ui';
import 'package:flutter/material.dart' hide Gradient;

/// 菜单光阴影动画组件
class TopMenuShadow extends StatefulWidget {
  const TopMenuShadow({
    super.key,
    required this.child,
  });

  /// 子容器
  final Widget child;

  @override
  State<TopMenuShadow> createState() => _TopMenuShadowState();
}

class _TopMenuShadowState extends State<TopMenuShadow> {
  /// 绘制
  late TopMenuShadowPainter _painter;

  @override
  void initState() {
    super.initState();
    _painter = TopMenuShadowPainter();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        _painter.updateEnter(true);
      },
      onExit: (event) {
        _painter.updateEnter(false);
      },
      onHover: (event) {
        _painter.updatePoint(event.localPosition.dx);
        //debugPrint("x:${event.localPosition.dx} y:${event.localPosition.dy}");
      },
      child: RepaintBoundary(
        //底层光圈绘制层
        child: CustomPaint(
          painter: _painter,
          child: widget.child,
        ),
      ),
    );
  }
}

class TopMenuShadowPainter extends ChangeNotifier implements CustomPainter {
  TopMenuShadowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    //debugPrint("TopMenuShadowPainter paint");
    debugPrint("重绘菜单");

    /// 没有进入不需要绘制
    if (!mouseEnter) {
      //debugPrint("没有进入不需要绘制 paint");
      return;
    }

    double ovalWidth = 80;
    var gradient = Gradient.radial(
      Offset(mouseX, ovalWidth),
      ovalWidth,
      [
        const Color(0xFF91887e),
        const Color(0xDD91887e),
        const Color(0x8891887e),
        // Colors.red, Colors.blue, Colors.yellow,
      ],
      [
        0,
        0.6,
        1,
      ],
    );

    var paint = Paint()
      ..shader = gradient
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30)
      ..strokeWidth = 1;

    // 设置裁剪区域，超出该区域不会绘制 Offset.zero  & size
    Rect clipRect =
        Rect.fromLTRB(-ovalWidth, 0, size.width + ovalWidth, size.height);
    canvas.clipRect(clipRect);

    canvas.drawOval(
      Rect.fromLTWH(
        mouseX - ovalWidth / 2,
        size.height / 2 + 10,
        ovalWidth,
        ovalWidth,
      ),
      paint,
    );

    // canvas.drawArc(
    //   Rect.fromLTWH(
    //     mouseX - ovalWidth / 2 - 10,
    //     size.height / 2,
    //     ovalWidth + 20,
    //     ovalWidth,
    //   ),
    //   pi,
    //   pi,
    //   true,
    //   paint,
    // );

    // canvas.drawArc(
    //   Rect.fromLTWH(
    //     mouseX - ovalWidth / 2,
    //     size.height / 2 + 10,
    //     ovalWidth,
    //     ovalWidth,
    //   ),
    //   paint,
    // );

    // 绘制金线
    // 计算金线的开始位置 鼠标的X坐标 减去 画刷宽度的一半
    Gradient lineColor = Gradient.linear(
      Offset(mouseX - 50, size.height),
      Offset(mouseX + 50, size.height),
      [
        Colors.transparent,
        const Color(0X88e2d7bf),
        const Color(0XFFe2d7bf),
        const Color(0X88e2d7bf),
        Colors.transparent,
      ],
      [0, .25, .5, .75, 1],
    );

    canvas.drawLine(
      Offset(mouseX - 50, size.height),
      Offset(mouseX + 50, size.height),
      Paint()
        ..strokeCap = StrokeCap.round
        ..shader = lineColor
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant TopMenuShadowPainter oldDelegate) {
    return mouseEnter != oldDelegate.mouseEnter || mouseX != oldDelegate.mouseX;
  }

  @override
  bool? hitTest(Offset position) => true;

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;

  /// 鼠标进入
  bool mouseEnter = false;

  // 鼠标的坐标点
  double mouseX = 0;

  /// 更新
  void updateEnter(bool newMouseEnter) {
    mouseEnter = newMouseEnter;
    //debugPrint("鼠标进入退出：$mouseEnter");
    notifyListeners();
  }

  /// 更新
  void updatePoint(double newMouseX) {
    mouseX = newMouseX;
    notifyListeners();
  }
}
