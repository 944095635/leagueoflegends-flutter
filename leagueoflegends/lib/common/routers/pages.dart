import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leagueoflegends/common/routers/names.dart';
import 'package:leagueoflegends/pages/cloud/view.dart';
import 'package:leagueoflegends/pages/frame/view.dart';
import 'package:leagueoflegends/pages/home/view.dart';
import 'package:leagueoflegends/pages/play/view.dart';
import 'package:leagueoflegends/pages/settings/view.dart';
import 'package:leagueoflegends/pages/store/view.dart';

class RoutePages {
  static Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == RouteNames.play) {
      return GetPageRoute(
        settings: settings,
        page: () => const PlayPage(),
        transition: Transition.topLevel,
      );
    } else if (settings.name == RouteNames.home) {
      return GetPageRoute(
        settings: settings,
        page: () => const HomePage(),
        transition: Transition.fadeIn,
      );
    } else if (settings.name == RouteNames.cloud) {
      return GetPageRoute(
        settings: settings,
        page: () => const CloudPage(),
        transition: Transition.fadeIn,
      );
    } else if (settings.name == RouteNames.store) {
      return GetPageRoute(
        settings: settings,
        page: () => const StorePage(),
        transition: Transition.fadeIn,
      );
    }
    return null;
  }

  // 列表
  static List<Page> list = [
    GetPage(
      name: RouteNames.cloud,
      page: () => const CloudPage(),
    ),
    GetPage(
      name: RouteNames.frame,
      page: () => const FramePage(),
    ),
    GetPage(
      name: RouteNames.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RouteNames.play,
      page: () => const PlayPage(),
    ),
    GetPage(
      name: RouteNames.settings,
      page: () => const SettingsPage(),
    ),
  ];
}
