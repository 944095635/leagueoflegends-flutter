import 'package:flutter/material.dart';
import 'package:flutter_styled/size_extension.dart';

/// 顶部金额
class TopMoney extends StatelessWidget {
  const TopMoney({
    super.key,
    required this.image,
    required this.money,
  });

  final String image;

  final String money;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          width: 14,
        ),
        5.horizontalSpace,
        Text(
          money,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
