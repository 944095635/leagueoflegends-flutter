import 'dart:math';

import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter_styled/radius_extension.dart';
import 'package:leagueoflegends/common/values/images.dart';
import 'package:leagueoflegends/common/widgets/play_button/play_button_painter.dart';

/// 开始按钮
class PlayButton extends StatefulWidget {
  const PlayButton({
    super.key,
    required this.text,
  });

  final String text;

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
    for (var i = 0; i < 13; i++) {
      double scale = Random().nextDouble() * 3 + 2;
      _lights.add(
        PlayButtonlight(
          x: i * 10,
          y: 2,
          scale: scale,
        ),
      );
      _lights.add(
        PlayButtonlight(
          x: i * 12,
          y: 24,
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
        Container(
          width: 165,
          height: 40,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF010a13),
            borderRadius: BorderRadius.horizontal(left: 20.radius),
            border: Border.all(
              color: const Color(0xFF34291E),
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: 20.radius),
              border: Border.all(
                color: const Color(0xFF09343D),
              ),
            ),
            child: Align(
              alignment: Alignment.centerRight,
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
                          child: Text(
                            widget.text,
                            textHeightBehavior: const TextHeightBehavior(
                              applyHeightToLastDescent: false,
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        Image.asset(
          AssetsImages.lolLogo,
          width: 40,
          height: 40,
        ),
      ],
    );
  }
}
