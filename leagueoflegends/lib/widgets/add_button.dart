import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

final Path plusPath = parseSvgPathData(
    "M4,0C4.24546,0,4.44444,0.198984,4.44444,0.444444L4.44444,3.55556L7.55556,3.55556C7.80101,3.55556,8,3.75454,8,4C8,4.24546,7.80101,4.44444,7.55556,4.44444L4.44444,4.44444L4.44444,7.55556C4.44444,7.80101,4.24546,8,4,8C3.75454,8,3.55556,7.80101,3.55556,7.55556L3.55556,4.44444L0.444444,4.44444C0.198984,4.44444,0,4.24546,0,4C0,3.75454,0.198984,3.55556,0.444444,3.55556L3.55556,3.55556L3.55556,0.444444C3.55556,0.198984,3.75454,0,4,0Z");

/// 添加按钮
class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  /// 绘制器
  final AddButtonPainter painter = AddButtonPainter();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        painter.update(true);
      },
      onExit: (event) {
        painter.update(false);
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 17, minWidth: 17),
        child: CustomPaint(
          painter: painter,
        ),
      ),
    );
  }
}

class AddButtonPainter extends ChangeNotifier implements CustomPainter {
  AddButtonPainter();

  @override
  bool shouldRepaint(covariant AddButtonPainter oldDelegate) {
    return mouseEnter != oldDelegate.mouseEnter;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = const Color(0xFF252a29);
    canvas.drawOval(
      Rect.fromLTWH(
        0,
        0,
        size.width,
        size.height,
      ),
      paint,
    );

    //#边框
    var paintLine = Paint()
      ..color = mouseEnter ? const Color(0xFFCCA826) : const Color(0xFF9A8F68)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawOval(
      Rect.fromLTWH(
        0,
        0,
        size.width,
        size.height,
      ),
      paintLine,
    );

    var plusPaint = Paint()..color = const Color(0xFF9A8F68);

    /// 获取SVG的宽度
    double svgWidth = plusPath.getBounds().width;

    // 定义缩放变换矩阵
    Matrix4 matrix = Matrix4.identity();

    // 缩放比例 目标宽度 除以 Svg宽度 再除以 2等于缩放比例
    double scale = size.width / svgWidth / 2;

    // 计算居中的偏移量
    var offsetX = (size.width - svgWidth * scale) / 2;
    var offsetY = (size.width - svgWidth * scale) / 2;

    // 偏移坐标点
    matrix.translate(offsetX, offsetY);

    // 在X和Y轴上缩放
    matrix.scale(scale);

    Path drawplusPath = Path();
    drawplusPath = plusPath.transform(matrix.storage);
    canvas.drawPath(drawplusPath, plusPaint);
  }

  @override
  bool? hitTest(Offset position) {
    return true;
  }

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;

  /// 鼠标进入
  bool mouseEnter = false;

  /// 更新
  void update(bool newMouseEnter) {
    mouseEnter = newMouseEnter;
    notifyListeners();
  }
}
