import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter_styled/radius_extension.dart';
import 'package:leagueoflegends/common/values/images.dart';
import 'package:path_drawing/path_drawing.dart';

/// 开始按钮 120 * 30
final Path playPath = parseSvgPathData(
    'M107.405,-0.00005100000000002325L0.499885955,0.024332999999999994L-0.458643,0.02455099999999999L0.40061009999999997,1.255481Q4.65908,7.66886,4.65908,15.706Q4.65908,23.7432,0.4006321,30.1566L-0.18832300000000002,31.0002L107.413,30.9809L121.169,15.495L107.405,-0.00005100000000002325ZM1.68959,29.9998L106.964,29.9809L119.831,15.495L106.956,1.000051L1.44415,1.024117Q5.65907,7.56777,5.65908,15.706Q5.65908,23.6038,1.68959,29.9998Z');

/// 开始按钮
class PlayButton extends StatefulWidget {
  const PlayButton({
    super.key,
    required this.text,
    this.onTap,
  });

  final Widget text;

  /// 点击事件
  final Function()? onTap;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  // 动画控制器
  late AnimationController _controller;
  late Animation<double> _animation;

  /// 光斑
  final List<PlayButtonlight> _lights = List.empty(growable: true);

  // 是否悬浮鼠标
  bool hover = false;

  @override
  void initState() {
    super.initState();

    init();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.slowMiddle,
    ));
  }

  void init() async {
    for (var i = 0; i < 20; i++) {
      double scale = Random().nextDouble() * 3 + 2;
      _lights.add(
        PlayButtonlight(
          x: i * 13,
          y: 6,
          scale: scale,
        ),
      );
      _lights.add(
        PlayButtonlight(
          x: i * 12,
          y: 23,
          scale: scale,
        ),
      );
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 165,
          height: 40,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xFF010a13),
              borderRadius: BorderRadius.horizontal(left: 20.radius),
              border: Border.all(
                color: const Color(0xFF34291E),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left: 20.radius),
                  border: Border.all(
                    width: 2,
                    color: const Color(0xFF09343D),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: widget.onTap,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (event) {
                        hover = true;
                        if (!_controller.isAnimating) {
                          //debugPrint("onEnter");
                          _controller.repeat();
                        }
                      },
                      onExit: (event) async {
                        hover = false;
                        await Future.delayed(Durations.long1);
                        if (!hover) {
                          _controller.reset();
                        }
                      },
                      child: SizedBox(
                        width: 120,
                        height: 30,
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            //debugPrint("重绘");
                            for (var light in _lights) {
                              light.doMove();
                            }
                            return CustomPaint(
                              painter: PlayButtonPainter(
                                _animation.value,
                                _lights,
                              ),
                              child: Center(
                                child: widget.text,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Image.asset(
          AssetsImages.lolLogo_03Png,
          width: 40,
          height: 40,
        ),
      ],
    );
  }
}

final Gradient playColor = Gradient.linear(
  Offset.zero,
  const Offset(0, 30),
  [
    const Color(0X883FE7FF),
    const Color(0X88006D7D),
    const Color(0X880493A7),
  ],
  [
    0,
    .5,
    1,
  ],
);

final playHoverColor = Gradient.linear(
  Offset.zero,
  const Offset(0, 30),
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

class PlayButtonPainter extends CustomPainter {
  const PlayButtonPainter(
    this.progress,
    this._lights,
  );

  /// 动画进度
  final double progress;

  /// 光斑
  final List<PlayButtonlight> _lights;

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制顶部的箭头形状
    Path arrowPath = Path();
    arrowPath.addPath(playPath, Offset(size.width - 120, -0.5));

    Paint arrowPaint = Paint()
      ..shader = progress == 1 ? playColor : playHoverColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(arrowPath, arrowPaint);

    if (progress < 1) {
      var paint = Paint()
        ..style = PaintingStyle.fill
        ..color = const Color.fromARGB(200, 0, 195, 234)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7.5);

      for (var light in _lights) {
        if (light.x < 110) {
          canvas.drawCircle(
            Offset(
              light.x,
              light.y,
            ),
            light.scale,
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant PlayButtonPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

/// 光点
class PlayButtonlight {
  /// 横向坐标
  double x;

  /// 纵向坐标
  late double y;

  /// 缩放
  late double scale;

  /// 某些光斑不会移动
  late bool move;

  PlayButtonlight({
    required this.x,
    required this.y,
    this.move = true,
    required this.scale,
  });

  void doMove() {
    // 每帧往左侧移动像素
    if (move) {
      x -= .3;
    }
    // 如果X低于0 让它回到起点 150 ，但是 大于110 不会绘制
    if (x < 0) {
      x = 130;
    }
  }
}
