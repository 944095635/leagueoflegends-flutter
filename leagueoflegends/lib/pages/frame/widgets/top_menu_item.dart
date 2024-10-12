import 'package:flutter/material.dart';
import 'package:leagueoflegends/common/index.dart';
import 'package:leagueoflegends/common/style/colors.dart';

/// 首页 - 顶部菜单
abstract class TopMenuItem extends StatelessWidget {
  const TopMenuItem({
    super.key,
    required this.title,
    required this.selectd,
    this.onTap,
    required this.index,
  });

  final int index;

  final String title;

  final bool selectd;

  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call(index);
      },
      behavior: HitTestBehavior.opaque,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
            fit: StackFit.passthrough,
            children: [
              if (selectd)
                Positioned(
                  left: 0,
                  top: 2,
                  right: 0,
                  child: Image.asset(
                    AssetsImages.menuSelected,
                    height: 12,
                  ),
                ),
              buildView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildView();
}
