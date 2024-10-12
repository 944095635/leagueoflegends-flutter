import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leagueoflegends/common/style/colors.dart';
import 'package:leagueoflegends/pages/frame/view.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  //客户端尺寸
  //1280*720
  //1600*900
  //1920*1080
  //2560*1440

  WidgetsFlutterBinding.ensureInitialized();
  // PC上面才设置窗口大小
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720),
      center: true,
      maximumSize: Size(1280, 720),
      minimumSize: Size(1280, 720),
      backgroundColor: Colors.black,
      titleBarStyle: TitleBarStyle.hidden,
    );
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'League of Legends',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(primary: SystemColors.themeColor),
      ),
      darkTheme: ThemeData(
        fontFamily: "MiSans",
        primaryColor: SystemColors.themeColor,
        colorScheme: const ColorScheme.dark(
          primary: SystemColors.themeColor, //主题色
          onSurface: SystemColors.foregroundColor, //部分区域的文字

          // secondary: Colors.white,
          // onSecondary: Colors.white,
          // surface: Colors.white, //表面颜色
          // surfaceTint: Colors.transparent,
          // background: Color(0xFF131314),
          // onBackground: Color(0xFF131314),
        ),
        scaffoldBackgroundColor: SystemColors.backgroundColor,
        dividerTheme: const DividerThemeData(
          color: Color(0xAA3d4143),
          thickness: 1,
        ),
      ),
      home: const FramePage(),
    );
  }
}
