import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:leagueoflegends/common/index.dart';

class FrameController extends GetxController {
  FrameController();

  _initData() {
    update(["frame"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
    precacheImage(const AssetImage(AssetsImages.code1Jpg), Get.context!);
    precacheImage(const AssetImage(AssetsImages.wallhaven_7pvod3Jpg), Get.context!);
    precacheImage(const AssetImage(AssetsImages.yasuoJpg), Get.context!);
    precacheImage(const AssetImage(AssetsImages.bgMapJpg), Get.context!);
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
