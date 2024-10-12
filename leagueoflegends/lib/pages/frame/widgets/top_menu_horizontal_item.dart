import 'package:flutter/material.dart';
import 'package:leagueoflegends/common/style/colors.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu_item.dart';

/// 首页 - 顶部菜单
class TopMenuHorizontalItem extends TopMenuItem {
  const TopMenuHorizontalItem({
    super.key,
    super.onTap,
    required super.title,
    super.selectd = false,
    required super.index,
  });

  @override
  Widget buildView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: super.selectd
                ? SystemColors.foregroundLightColor
                : SystemColors.foregroundColor,
          ),
        ),
      ),
    );
  }
}
