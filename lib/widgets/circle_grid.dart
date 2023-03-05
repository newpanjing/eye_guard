import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:eye_guard/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CircleGrid extends StatefulWidget {
  final List<Function> listeners = [];

  register(callback) {
    listeners.add(callback);
  }

  void start() {
    for (var element in listeners) {
      element(true);
    }
  }

  void stop() {
    for (var element in listeners) {
      element(false);
    }
  }

  CircleGrid({Key? key}) : super(key: key);

  @override
  State<CircleGrid> createState() => _CircleGridState();
}

class _CircleGridState extends State<CircleGrid>
    with SingleTickerProviderStateMixin {
  var padding = 30.0;
  var x = 12.0;
  var y = 12.0;

  var oldX = 12.0;
  var oldY = 12.0;
  late AnimationController controller;
  var isRuning = false;

  start() async {
    controller.stop();
    //用动画来移动
    controller.reset();
    //如果控制器已经被释放，那么就重新创建一个
    controller.clearListeners();
    controller.clearStatusListeners();

    print("start -- x,y: $x,$y");
    var offset = await next();

    //求两点之间的距离
    var distance = sqrt(pow(offset.dx - x, 2) + pow(offset.dy - y, 2));
    print("距离：$distance");

    //求两点之间的时间
    var time = distance * 3;
    print("移动的时间：$time ms");

    controller.duration = Duration(milliseconds: time.toInt());

    var begin = Offset(oldX, oldY);
    oldX = offset.dx;
    oldY = offset.dy;

    var end = offset;

    print("begin: $begin");
    print("end: $end");

    var animation = Tween<Offset>(begin: begin, end: end).animate(controller);

    animation.addListener(() {
      var value = animation.value;
      setState(() {
        x = value.dx;
        y = value.dy;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && isRuning) {
        play();
        //延迟一秒再次移动
        Future.delayed(const Duration(milliseconds: 500), () {
          start();
        });
      }
    });
    controller.forward();
  }

  next() async {
    //计算x和y的值

    //获取当前组件的宽高
    var size = context.size;

    var gridSize =
        getWidgetSize(Size(size!.width - 40.0, size.height - 40.0), padding);

    var xCount = gridSize.xCount;
    var yCount = gridSize.yCount;

    //随机一个x
    var xIndex = Random().nextInt(xCount);
    //随机一个y
    var yIndex = Random().nextInt(yCount);

    var newX = (gridSize.gridSize.width * xIndex) + 12;

    var newY = (gridSize.gridSize.height * yIndex) + 12;

    return Offset(newX, newY);
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    widget.register(onStatus);
  }

  final _audioPlayer = AudioPlayer();

  onStatus(flag) {
    if (flag) {
      isRuning = true;
      start();
    } else {
      isRuning = false;
      controller.stop();
    }
  }

  play() async {
    //播放声音
    await _audioPlayer.play(AssetSource('sound.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    //画网格
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CustomPaint(
        painter: GridPainter(),
        child: Stack(
          children: [
            Positioned(
                left: x,
                top: y,
                child: Container(
                  width: 37,
                  height: 37,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var padding = 30.0;

    var strokeWidth = 3.0;
    var circleSize = 20.0;

    var gridSize = getWidgetSize(size, padding);

    var xCount = gridSize.xCount;
    var yCount = gridSize.yCount;
    var width = gridSize.size.width;
    var height = gridSize.size.height;

    var xWidth = gridSize.gridSize.width;
    var yHeight = gridSize.gridSize.height;

//画笔
    Paint paint = Paint()
      ..color = const Color(0xff4f4e52)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var zero = padding;

    //画x轴
    for (int i = 0; i <= xCount; i++) {
      var x = xWidth * i + zero;
      canvas.drawLine(Offset(x, zero), Offset(x, height + zero), paint);
    }

    //画y轴
    for (int i = 0; i <= yCount; i++) {
      var y = yHeight * i + zero;
      canvas.drawLine(Offset(zero, y), Offset(width + zero, y), paint);
    }

    //画圆
    Paint paintCircle = Paint()
      ..color = const Color(0xff8caf5c)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    //在x和y交汇的地方画圆
    for (int i = 0; i <= xCount; i++) {
      for (int j = 0; j <= yCount; j++) {
        var x = xWidth * i + zero;
        var y = yHeight * j + zero;
        canvas.drawCircle(Offset(x, y), circleSize, paintCircle);
        //画实心圆
        Paint paintCircleFill = Paint()
          ..color = const Color(0xff000000)
          ..strokeWidth = 1
          ..style = PaintingStyle.fill;
        canvas.drawCircle(
            Offset(x, y), circleSize - strokeWidth, paintCircleFill);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
