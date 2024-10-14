import 'package:flutter/widgets.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:leagueoflegends/common/values/images.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu_type.dart';
import 'package:leagueoflegends/widgets/play_button/play_button.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu_divider.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu_horizontal_item.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu_vertical_item.dart';

/// 顶部菜单
class TopMenu extends StatefulWidget {
  const TopMenu({
    super.key,
    this.onChangeMenu,
  });

  final Function(TopMenuType menu)? onChangeMenu;

  @override
  State<TopMenu> createState() => _TopMenuState();
}

/// PLAY - 主页 - 云顶之奕 - 2024 总决赛 - 藏品 - 战利品  - 商城
class _TopMenuState extends State<TopMenu> {
  /// 选择的菜单
  late TopMenuType selectMenu;

  @override
  void initState() {
    super.initState();
    selectMenu = TopMenuType.home;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        28.horizontalSpace,
        PlayButton(
          onTap: () {
            onChangeMenu(TopMenuType.play);
          },
          text: const Text(
            "PLAY",
            textHeightBehavior: TextHeightBehavior(
              applyHeightToLastDescent: false,
            ),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        20.horizontalSpace,
        TopMenuHorizontalItem(
          title: "主页",
          menu: TopMenuType.home,
          selectd: selectMenu == TopMenuType.home,
          onTap: onChangeMenu,
        ),
        TopMenuHorizontalItem(
          title: "云顶之奕",
          menu: TopMenuType.tft,
          selectd: selectMenu == TopMenuType.tft,
          onTap: onChangeMenu,
        ),
        120.horizontalSpace,
        TopMenuVerticalItem(
          title: "2024 全球总决赛",
          menu: TopMenuType.other,
          image: AssetsImages.worlds2023TrackerIconPng,
          selectd: selectMenu == TopMenuType.other,
          onTap: onChangeMenu,
        ),
        const TopMenuDivider(),
        TopMenuVerticalItem(
          title: "藏品",
          menu: TopMenuType.other,
          image: AssetsImages.lolLogo_03Png,
          selectd: selectMenu == TopMenuType.other,
          onTap: onChangeMenu,
        ),
        const TopMenuDivider(),
        TopMenuVerticalItem(
          title: "战利品",
          menu: TopMenuType.other,
          image: AssetsImages.esportsWatchSeriesIconPng,
          selectd: selectMenu == TopMenuType.other,
          onTap: onChangeMenu,
        ),
        TopMenuVerticalItem(
          title: "商城",
          menu: TopMenuType.other,
          image: AssetsImages.esportsWatchSeriesIconPng,
          selectd: selectMenu == TopMenuType.other,
          onTap: onChangeMenu,
        ),
        const TopMenuDivider(),
      ],
    );
  }

  onChangeMenu(TopMenuType menu) {
    selectMenu = menu;
    setState(() {});
    widget.onChangeMenu?.call(menu);
  }
}
