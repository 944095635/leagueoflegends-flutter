import 'package:flutter/material.dart';
import 'package:flutter_styled/radius_extension.dart';

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
        height: 60,
        child: Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: const Color.fromARGB(255, 163, 108, 12),
                ),
                borderRadius: 100.borderRadius,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 163, 108, 12),
                    spreadRadius: .5,
                    blurRadius: 2,
                  )
                ],
              ),
              padding: const EdgeInsets.all(2),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    margin: const EdgeInsets.all(2.6),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 242, 156, 6),
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
                      value: .65,
                      color: Color.fromARGB(255, 16, 165, 184),
                      backgroundColor: Color(0xFF092f38),
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
