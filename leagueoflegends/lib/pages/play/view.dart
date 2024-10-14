import 'package:flutter/material.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:get/get.dart';
import 'package:leagueoflegends/common/index.dart';
import 'package:leagueoflegends/widgets/play_button/play_button.dart';

import 'index.dart';

class PlayPage extends GetView<PlayController> {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AssetsImages.bgMapJpg,
            fit: BoxFit.cover,
          ),
          // 半透明黑色渐变蒙版
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black87,
                  Colors.black54,
                  Colors.black12,
                ],
              ),
            ),
          ),
          _buildView(),
        ],
      ),
    );
  }

  Widget _buildItem(String image, String type, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Image.asset(
            image,
            width: 100,
            height: 100,
          ),
          Text(
            type,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          160.verticalSpace,
          Row(
            children: [
              _buildItem(AssetsImages.play1, "5v5", "召唤师峡谷"),
              80.horizontalSpace,
              _buildItem(AssetsImages.play2, "5v5", "极地大乱斗"),
            ],
          ),
          30.verticalSpace,
          const Divider(
            thickness: 1,
          ),
          20.verticalSpace,
          const Text(
            "五人一队，在核心竞技模式中战胜对\r\n手并摧毁地方水晶枢纽。",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Center(
            child: PlayButton(
              text: "确认",
            ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
