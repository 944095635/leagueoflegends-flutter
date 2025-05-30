import 'package:flutter/widgets.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:leagueoflegends/common/style/colors.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu_item.dart';

/// 顶部菜单 小型 + 图标
class TopMenuVerticalItem extends TopMenuItem {
  const TopMenuVerticalItem({
    super.key,
    super.onTap,
    required this.image,
    required super.title,
    super.selectd = false,
    required super.menu,
  });

  final Widget image;

  @override
  Widget buildView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image,
          5.verticalSpace,
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: super.selectd
                  ? SystemColors.foregroundLightColor.withAlpha(240)
                  : SystemColors.foregroundColor.withAlpha(220),
            ),
          ),
        ],
      ),
    );
  }
}
