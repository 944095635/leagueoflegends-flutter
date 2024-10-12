import 'package:flutter/widgets.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:leagueoflegends/common/values/images.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu_divider.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu_horizontal_item.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu_vertical_item.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_play_button.dart';

/// 顶部菜单
class TopMenu extends StatefulWidget {
  const TopMenu({super.key});

  @override
  State<TopMenu> createState() => _TopMenuState();
}

class _TopMenuState extends State<TopMenu> {
  late int selectIndex;

  @override
  void initState() {
    super.initState();
    selectIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        28.horizontalSpace,
        const TopPlayButton(),
        65.horizontalSpace,
        TopMenuHorizontalItem(
          title: "主页",
          index: 1,
          selectd: selectIndex == 1,
          onTap: onTapMenu,
        ),
        TopMenuHorizontalItem(
          title: "云顶之奕",
          index: 2,
          selectd: selectIndex == 2,
          onTap: onTapMenu,
        ),
        120.horizontalSpace,
        TopMenuVerticalItem(
          title: "2024 全球总决赛",
          index: 3,
          image: AssetsImages.lolLogo,
          selectd: selectIndex == 3,
          onTap: onTapMenu,
        ),
        const TopMenuDivider(),
        TopMenuVerticalItem(
          title: "藏品",
          index: 4,
          image: AssetsImages.lolLogo,
          selectd: selectIndex == 4,
          onTap: onTapMenu,
        ),
        const TopMenuDivider(),
        TopMenuVerticalItem(
          index: 5,
          title: "战利品",
          image: AssetsImages.lolLogo,
          selectd: selectIndex == 5,
          onTap: onTapMenu,
        ),
        TopMenuVerticalItem(
          index: 6,
          title: "商城",
          image: AssetsImages.lolLogo,
          selectd: selectIndex == 6,
          onTap: onTapMenu,
        ),
        const TopMenuDivider(),
      ],
    );
  }

  void onTapMenu(int index) {
    selectIndex = index;
    setState(() {});
  }
}
