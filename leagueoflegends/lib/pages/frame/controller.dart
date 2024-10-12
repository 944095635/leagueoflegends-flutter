import 'package:get/get.dart';

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
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
