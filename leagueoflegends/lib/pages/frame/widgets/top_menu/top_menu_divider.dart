import 'package:flutter/material.dart';
import 'package:leagueoflegends/common/style/colors.dart';

// 分割线
class TopMenuDivider extends StatelessWidget {
  const TopMenuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            SystemColors.dividerColor,
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SizedBox(
        width: 1.5,
      ),
    );
  }
}
