import 'package:flutter/widgets.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leagueoflegends/common/index.dart';
import 'package:leagueoflegends/common/style/colors.dart';
import 'package:leagueoflegends/common/values/images.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu_type.dart';
import 'package:leagueoflegends/widgets/play_button/play_button.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu_divider.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu_horizontal_item.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu_vertical_item.dart';

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        28.horizontalSpace,
        Center(
          child: PlayButton(
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
          menu: TopMenuType.world,
          image: SvgPicture.asset(
            AssetsSvgs.worlds_2023Svg,
            width: 20,
            height: 20,
            color: selectMenu == TopMenuType.world
                ? SystemColors.foregroundLightColor
                : SystemColors.foregroundColor,
          ),
          selectd: selectMenu == TopMenuType.world,
          onTap: onChangeMenu,
        ),
        const TopMenuDivider(),
        TopMenuVerticalItem(
          title: "藏品",
          menu: TopMenuType.collection,
          image: Image.asset(
            AssetsImages.mtTargonCrestIconPng,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
          selectd: selectMenu == TopMenuType.collection,
          onTap: onChangeMenu,
        ),
        const TopMenuDivider(),
        TopMenuVerticalItem(
          title: "战利品",
          menu: TopMenuType.spoils,
          image: Image.asset(
            AssetsImages.bilgewaterCrestIconPng,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
          selectd: selectMenu == TopMenuType.spoils,
          onTap: onChangeMenu,
        ),
        TopMenuVerticalItem(
          title: "商城",
          menu: TopMenuType.store,
          image: Image.asset(
            AssetsImages.shurimaCrestIconPng,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
          selectd: selectMenu == TopMenuType.store,
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
