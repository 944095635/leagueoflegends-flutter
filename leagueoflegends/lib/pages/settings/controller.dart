import 'package:get/get.dart';

class SettingsController extends GetxController {
  SettingsController();

  _initData() {
    update(["settings"]);
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
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
