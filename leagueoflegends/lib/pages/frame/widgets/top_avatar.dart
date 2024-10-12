import 'package:flutter/material.dart';
import 'package:flutter_styled/radius_extension.dart';
import 'package:leagueoflegends/common/style/colors.dart';

/// 头像
class TopAvatar extends StatelessWidget {
  const TopAvatar({
    super.key,
    required this.avatar,
  });

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 60,
        height: 62,
        child: Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.5,
                  color: SystemColors.themeColor,
                ),
                borderRadius: 100.borderRadius,
                
              ),
              padding: const EdgeInsets.all(1.5),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    margin: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.5,
                        color: SystemColors.themeColor,
                      ),
                      borderRadius: 100.borderRadius,
                      image: DecorationImage(
                        image: AssetImage(
                          avatar,
                        ),
                      ),
                    ),
                  ),
                  const RotatedBox(
                    quarterTurns: 2,
                    child: CircularProgressIndicator(
                      value: .45,
                      color: Color(0xFF0596aa),
                      backgroundColor: Color(0xFF082730),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 16,
                width: 38,
                child: Material(
                  color: const Color(0xFF1d2227),
                  shape: BeveledRectangleBorder(
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xFFb38d40),
                    ),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Center(
                    child: Text(
                      '1215',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFa09b8c),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
