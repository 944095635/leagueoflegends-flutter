import 'package:flutter/material.dart';
import 'package:leagueoflegends/common/index.dart';
import 'package:leagueoflegends/common/style/colors.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu_type.dart';

/// 首页 - 顶部菜单
abstract class TopMenuItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    //debugPrint("重绘${widget.title}");
    return GestureDetector(
      onTap: () {
        onTap?.call(menu);
      },
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: selectd
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
            buildView(),
            if (selectd)
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
    );
  }

  /// 虚方法
  Widget buildView();
}
