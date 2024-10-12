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
    precacheImage(const AssetImage(AssetsImages.code), Get.context!);
    precacheImage(const AssetImage(AssetsImages.nami), Get.context!);
    precacheImage(const AssetImage(AssetsImages.yasuo), Get.context!);
    precacheImage(const AssetImage(AssetsImages.bg), Get.context!);
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
