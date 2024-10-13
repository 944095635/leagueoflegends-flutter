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

    // 构建光斑动画元素 - 上方

    _lights.add(PlayButtonlight(x: 10));
    _lights.add(PlayButtonlight(x: 17));
    _lights.add(PlayButtonlight(x: 28));
    _lights.add(PlayButtonlight(x: 43));
    _lights.add(PlayButtonlight(x: 69));
    _lights.add(PlayButtonlight(x: 80));
    _lights.add(PlayButtonlight(x: 108));

    _lights.add(PlayButtonlight(x: 0, bottom: true));
    _lights.add(PlayButtonlight(x: 15, bottom: true));
    _lights.add(PlayButtonlight(x: 20, bottom: true));
    _lights.add(PlayButtonlight(x: 35, bottom: true));
    _lights.add(PlayButtonlight(x: 40, bottom: true));
    _lights.add(PlayButtonlight(x: 78, bottom: true));
    _lights.add(PlayButtonlight(x: 80, bottom: true));
    _lights.add(PlayButtonlight(x: 98, bottom: true));
    _lights.add(PlayButtonlight(x: 108, bottom: true));

    _lights.add(PlayButtonlight(x: 0, move: false));
    _lights.add(PlayButtonlight(x: 0, bottom: true, move: false));

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    ); // 动画无限循环，并且反向播放

    _animation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.slowMiddle,
    ));
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
