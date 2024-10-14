import 'package:flutter/material.dart';
import 'package:leagueoflegends/common/index.dart';
import 'package:leagueoflegends/common/style/colors.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu_item_painter.dart';
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
  double mouseX = 0;

  bool enter = false;

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
          enter = true;
          setState(() {});
        },
        onExit: (event) {
          enter = false;
          setState(() {});
        },
        onHover: (event) {
          mouseX = event.localPosition.dx;
          setState(() {});
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
              RepaintBoundary(
                key: GlobalKey(),
                child: CustomPaint(
                  painter: TopMenuItemPainter(mouseX, enter: enter),
                  child: widget.buildView(),
                ),
              ),
              if (widget.selectd)
                Positioned(
                  left: 0,
                  top: 2.5,
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
