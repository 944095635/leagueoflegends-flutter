# 英雄联盟 LOL - leagueoflegends

### Flutter 编写，被人怼了，不想写了，最近更新 2024-10-12


### Flutter 技术交流QQ群 ：623512997

<img src="https://raw.githubusercontent.com/944095635/leagueoflegends-flutter/master/images/LOL.png" width='600'>

<img src="https://raw.githubusercontent.com/944095635/leagueoflegends-flutter/master/images/LOL1.png" width='600'>

| 平台 | 支持 | 说明 | 下载 |
| -------- | ----- | ----- | ---- |
| Android Pad    | ✅    | 平板 Tablet 电视 TV  | [-](https://github.com/) |
| Android Phone    | ⛔    | 不准备支持 | 尺寸不匹配 |
| IOS Phone      | ⛔    | 不准备支持 | 尺寸不匹配 |
| macOS       | ✅    | 等待         |  |
| Windows     | ✅    | Windows 7 以上的64位系统. | [-](https://github.com/) / 可能需要安装C++ runtime 2015|
| GNU/Linux   | ✅    | 等待   |   |
| Web         | ✅    | 等待    |  |

### 技术点分享
#### 绘制Svg的时候等比缩放和偏移
```
var plusPaint = Paint()..color = const Color(0xFF9A8F68);
// 获取SVG的宽度
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

// 绘制PATH
drawplusPath = plusPath.transform(matrix.storage);
canvas.drawPath(drawplusPath, plusPaint);
```
