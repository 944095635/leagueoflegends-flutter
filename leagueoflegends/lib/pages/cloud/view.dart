import 'package:flutter/material.dart';
import 'package:leagueoflegends/common/values/images.dart';

class CloudPage extends StatelessWidget {
  const CloudPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackground(),
          // 半透明黑色渐变蒙版
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black54,
                  Colors.black12,
                  Colors.black12,
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Image.asset(
      AssetsImages.wallhaven_7pvod3Jpg,
      cacheWidth: 3120,
      fit: BoxFit.cover,
    );
  }
}
