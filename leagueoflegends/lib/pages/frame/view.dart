import 'package:flutter/material.dart';
import 'package:flutter_styled/radius_extension.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:flutter_styled/padding_extension.dart';
import 'package:get/get.dart';
import 'package:leagueoflegends/common/index.dart';
import 'package:leagueoflegends/common/style/colors.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_avatar.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_menu/top_menu_type.dart';
import 'package:leagueoflegends/pages/frame/widgets/top_money.dart';
import 'package:window_manager/window_manager.dart';

import 'index.dart';

class FramePage extends GetView<FrameController> {
  const FramePage({super.key});

  /// 底部是一个动态的背景图
  /// 顶部是一根金属条
  /// 顶部是一个半透明黑色渐变蒙版
  ///
  @override
  Widget build(BuildContext context) {
    Get.put(FrameController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Navigator(
            key: Get.nestedKey(1),
            initialRoute: RouteNames.home,
            onGenerateRoute: RoutePages.onGenerateRoute,
          ),
          Column(
            children: [
              _buildAppBar(context),
              const Divider(height: 1),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SizedBox(
      height: 82,
      width: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: SystemColors.themeColor, width: 2.5),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DragToMoveArea(child: SizedBox()),
            Row(
              children: [
                TopMenu(onChangeMenu: onChangeMenu),
                20.horizontalSpace,
                _buildMoney(),
                const Spacer(),
                _buildUserInfo(),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 货币区域
  Widget _buildMoney() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF3d4143),
            ),
            borderRadius: 20.borderRadius,
          ),
          child: const TopMoney(
            image: AssetsImages.lolLogo_03Png,
            money: "100886",
          ),
        ),
        5.verticalSpace,
        Padding(
          padding: 10.horizontal,
          child: const TopMoney(
            image: AssetsImages.lolBlueEssencePng,
            money: "19.9万",
          ),
        ),
      ],
    );
  }

  /// 用户信息
  Widget _buildUserInfo() {
    return SizedBox(
      width: 220,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          10.horizontalSpace,
          const TopAvatar(
            avatar: AssetsImages.code1Jpg,
          ),
          10.horizontalSpace,
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dream.Machine",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 239, 227, 198),
                ),
              ),
              Text(
                "在线",
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF00a72e),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// 切换菜单
  void onChangeMenu(TopMenuType menu) {
    String newRoutes;
    switch (menu) {
      case TopMenuType.play:
        newRoutes = RouteNames.play;
        break;
      case TopMenuType.home:
        newRoutes = RouteNames.home;
        break;
      default:
        newRoutes = RouteNames.store;
    }

    if (newRoutes.isNotEmpty && Get.currentRoute != newRoutes) {
      Get.offNamed(newRoutes, id: 1);
    }
  }
}
