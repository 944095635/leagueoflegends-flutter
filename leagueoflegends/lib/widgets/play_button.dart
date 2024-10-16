import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter/scheduler.dart';
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

class _PlayButtonState extends State<PlayButton> {
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
                        mouserEnter();
                      },
                      onExit: (event) {
                        mouserOut();
                      },
                      child: SizedBox(
                        width: 120,
                        height: 30,
                        child: RepaintBoundary(
                          child: CustomPaint(
                            isComplex: true,
                            painter: _painter,
                            child: Center(
                              child: widget.text,
                            ),
                          ),
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

  // 画刷
  late PlayButtonPainter _painter;

  // Tiker 触发器
  late Ticker _ticker;

  // 是否悬浮鼠标
  bool mouseEnter = false;

  @override
  void initState() {
    super.initState();
    _painter = PlayButtonPainter();
    _ticker = Ticker(_onTick);
  }

  /// 间隔
  int elapsed = 0;

  void _onTick(Duration newElapsed) {
    //debugPrint("OnTick:$elapsed");
    elapsed++;
    if (elapsed > 14) {
      elapsed = 0;
      _painter.update();
    }
  }

  /// 鼠标进入
  void mouserEnter() {
    mouseEnter = true;
    _painter.updateState(true);
    if (!_ticker.isTicking) {
      //debugPrint("onEnter");
      _ticker.start();
    }
  }

  /// 鼠标离开
  void mouserOut() async {
    mouseEnter = false;
    await Future.delayed(Durations.long1);
    if (!mouseEnter) {
      _ticker.stop();
      _painter.updateState(false);
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _painter.dispose();
    super.dispose();
  }
}

class PlayButtonPainter extends ChangeNotifier implements CustomPainter {
  PlayButtonPainter() {
    //debugPrint("PlayButtonPainter 初始化");
    PathMetrics pathMetrics = playPath.computeMetrics();
    //获取第一小节信息
    PathMetric pathMetric = pathMetrics.first;

    // 获取顶部路径
    PathMetric topPathMetric = pathMetric
        .extractPath(
          0,
          pathMetric.length * .45,
          startWithMoveTo: true,
        )
        .computeMetrics()
        .first;

    // 截取顶部的路径
    firstPathPoints = splitPath(topPathMetric);

    // 获取底部部路径
    PathMetric bottomPathMetric = pathMetric
        .extractPath(
          pathMetric.length * .45,
          pathMetric.length,
          startWithMoveTo: false,
        )
        .computeMetrics()
        .first;
    // 截取底部路径
    lastPathPoints = splitPath(bottomPathMetric).reversed.toList();

    // 产生光点
    for (var i = 0; i < pointCount; i++) {
      double radius = Random().nextDouble() * 2 + 2;
      _lights.add(PlayButtonLight(offset: i, radius: radius));
    }
  }

  /// 拆分路径
  List<Offset> splitPath(PathMetric pathMetric) {
    List<Offset> points = [];
    for (var i = 0; i < pointCount; i++) {
      Tangent? tangent =
          pathMetric.getTangentForOffset(pathMetric.length * i / pointCount);
      if (tangent != null) {
        points.add(tangent.position);
      }
    }
    return points;
  }

  /// 移动光点
  void moveLight() {
    for (var light in _lights) {
      light.offset++;
      if (light.offset >= pointCount) {
        light.offset = 0;
      }
    }
  }

  // 将路径拆分成 多个点位
  final int pointCount = 30;

  /// 第一段路径上面的点集合
  late List<Offset> firstPathPoints;

  /// 第二段路径上面的点集合
  late List<Offset> lastPathPoints;

  /// 光斑
  final List<PlayButtonLight> _lights = List.empty(growable: true);

  @override
  void paint(Canvas canvas, Size size) {
    //debugPrint("重绘 Play");

    /// 判断动画是否启动
    //debugPrint("判断动画是否启动");

    //hover Color
    // const Color(0xFFAFF5FF),
    // const Color(0xFF46E6FF),
    // const Color(0xFF00ADD4),

    //Color
    // const Color(0X883FE7FF),
    // const Color(0X88006D7D),
    // const Color(0XFF0493A7),

    Paint arrowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = mouseEnter ? const Color(0xFFAFF5FF) : const Color(0xFF33B6CA)
      ..strokeWidth = 1.5;
    canvas.drawPath(playPath, arrowPaint);

    if (mouseEnter) {
      var paint = Paint()
        ..color = const Color.fromARGB(255, 0, 195, 220)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.5);

      for (var element in _lights) {
        canvas.drawCircle(
          firstPathPoints[element.offset],
          element.radius,
          paint,
        );

        canvas.drawCircle(
          lastPathPoints[element.offset],
          element.radius,
          paint,
        );
      }
    }
  }

  @override
  bool? hitTest(Offset position) => true;

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;

  @override
  bool shouldRepaint(covariant PlayButtonPainter oldDelegate) {
    return false;
  }

  // 鼠标状态
  bool mouseEnter = false;

  /// 更新 状态
  void updateState(bool enter) {
    mouseEnter = enter;
    notifyListeners();
  }

  /// 更新
  void update() {
    moveLight();
    notifyListeners();
  }
}

/// 光点
class PlayButtonLight {
  /// 当前光点的偏移量
  /// 以确定它在动画时间轴中所处的位置
  late int offset;

  /// 范围可以控制在 1~3
  late double radius;

  PlayButtonLight({
    required this.offset,
    required this.radius,
  });
}
