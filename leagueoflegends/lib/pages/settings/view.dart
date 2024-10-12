import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("SettingsPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      id: "settings",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("settings")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
