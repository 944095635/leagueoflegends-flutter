import 'dart:ui';

import 'package:flutter/material.dart' hide Gradient;
import 'package:leagueoflegends/common/index.dart';
import 'package:leagueoflegends/common/style/colors.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu_type.dart';

/// 首页 - 顶部菜单
abstract class TopMenuItem extends StatefulWidget {
  const TopMenuItem({
    super.key,
    this.onTap,
    required this.menu,
    required this.title,
    required this.selectd,
  });

  /// 当前菜单类型
  final TopMenuType menu;

  /// 文字
  final String title;

  /// 是否选中
  final bool selectd;

  final Function(TopMenuType menu)? onTap;

  @override
  State<TopMenuItem> createState() => _TopMenuItemState();

  /// 虚方法
  Widget buildView();
}

class _TopMenuItemState extends State<TopMenuItem> {
  /// 绘制
  final TopMenuItemPainter _painter = TopMenuItemPainter();

  @override
  Widget build(BuildContext context) {
    //debugPrint("重绘${widget.title}");
    return GestureDetector(
      onTap: () {
        widget.onTap?.call(widget.menu);
      },
      behavior: HitTestBehavior.opaque,
      child: MouseRegion(
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
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: widget.selectd
                ? const LinearGradient(
                    colors: [
                      Colors.transparent,
                      SystemColors.themeColor20,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
          ),
          child: Stack(
            children: [
              CustomPaint(
                painter: _painter,
                child: widget.buildView(),
              ),
              if (widget.selectd)
                Positioned(
                  left: 0,
                  top: 1,
                  right: 0,
                  child: Image.asset(
                    AssetsImages.iconMenuSelectedPng,
                    height: 12,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopMenuItemPainter extends ChangeNotifier implements CustomPainter {
  TopMenuItemPainter();

  @override
  void paint(Canvas canvas, Size size) {
    //debugPrint("TopMenuItemPainter paint");
    //debugPrint("鼠标：$mouseEnter");

    /// 没有进入不需要绘制
    if (!mouseEnter) {
      //debugPrint("没有进入不需要绘制 paint");
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
