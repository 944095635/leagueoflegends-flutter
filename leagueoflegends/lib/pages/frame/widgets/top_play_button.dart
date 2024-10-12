import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart' hide Gradient;
import 'package:leagueoflegends/common/index.dart';

/// 顶部开始游戏按钮
class TopPlayButton extends StatefulWidget {
  const TopPlayButton({super.key});

  @override
  State<TopPlayButton> createState() => _TopPlayButtonState();
}

class _TopPlayButtonState extends State<TopPlayButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 32,
            right: 0,
            top: 22,
            bottom: 22,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (event) {
                setState(() {
                  hover = true;
                });
              },
              onExit: (event) {
                setState(() {
                  hover = false;
                });
              },
              child: CustomPaint(
                painter: PlayPainter(hover),
                child: const Center(
                  child: Text(
                    "PLAY",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFe7decb),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              AssetsImages.lolLogo,
              width: 46,
              height: 46,
            ),
          ),
        ],
      ),
    );
  }
}

class PlayPainter extends CustomPainter {
  final bool hover;

  const PlayPainter(this.hover);

  @override
  void paint(Canvas canvas, Size size) {
    double gap = 4;

    // 边框
    Path border1 = Path();
    border1.lineTo(size.width, 0);
    border1.lineTo(size.width, size.height);
    border1.lineTo(0, size.height);
    border1.lineTo(0, 0);

    // 绘制边框
    Paint paint = Paint();
    paint.color = const Color(0xFF34291E);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    canvas.drawPath(border1, paint);

    // 绘制背景
    Paint paint1 = Paint()..color = const Color(0xFF00070E);
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint1);

    // 边框
    Path border2 = Path();
    border2.moveTo(gap, gap);
    border2.lineTo(size.width - gap, gap);
    border2.lineTo(size.width - gap, size.height - gap);
    border2.lineTo(gap, size.height - gap);
    border2.lineTo(gap, gap);

    Paint paint2 = Paint();
    paint2.color = const Color(0xFF09343D);
    paint2.style = PaintingStyle.stroke;
    paint2.strokeWidth = 3;
    canvas.drawPath(border2, paint2);

    // 绘制背景
    Paint paint3 = Paint()..color = const Color(0xFF1E2328);
    canvas.drawRect(
        Rect.fromLTRB(gap, gap, size.width - gap, size.height - gap), paint3);

    // 绘制箭头
    Path borde3 = Path();
    borde3.moveTo(3 * gap, gap);
    borde3.lineTo(size.width - gap * 5, gap);
    borde3.lineTo(size.width - gap, size.height / 2);
    borde3.lineTo(size.width - gap * 5, size.height - gap);
    borde3.lineTo(3 * gap, size.height - gap);
    //borde3.lineTo(gap, gap);
    borde3.arcTo(
      Rect.fromLTWH(gap, gap, 14, size.height - 2 * gap),
      3 * pi / 2,
      pi,
      true,
    );
    Paint paintTop = Paint();
    paintTop.color = const Color(0xCC0493A7);
    paintTop.style = PaintingStyle.stroke;
    paintTop.strokeWidth = 2;

    if (hover) {
      paintTop.shader = Gradient.linear(
        Offset.zero,
        Offset.zero,
        [
          const Color(0xFFAFF5FF),
          const Color(0xFF46E6FF),
          const Color(0xFF00ADD4),
        ],
        [
          0,
          .5,
          1,
        ],
      );
    } else {
      paintTop.shader = Gradient.linear(
        Offset.zero,
        Offset.zero,
        [
          const Color(0XCC3FE7FF),
          const Color(0XCC006D7D),
          const Color(0XCC0493A7),
        ],
        [
          0,
          .5,
          1,
        ],
      );
    }
    Paint paintTopFill = Paint();
    paintTopFill.color = const Color(0xFF1e2328);
    canvas.drawPath(borde3, paintTopFill);

    canvas.drawPath(borde3, paintTop);
    canvas.drawShadow(borde3, Colors.black, 1, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
