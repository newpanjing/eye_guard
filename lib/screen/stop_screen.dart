import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_magic/magic.dart';
import 'package:get/get.dart';

class StopScreen extends StatefulWidget {
  const StopScreen({super.key});

  @override
  State<StopScreen> createState() => _StopScreenState();
}

class _StopScreenState extends State<StopScreen> {
  var start = false.obs;
  var time = 10.0.obs;
  var totalSeconds = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // 格式化时间为 MM:SS
  String get formattedTime {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // 开始倒计时
  void startCountdown() {
    totalSeconds = time.value.round() * 60;
    start.value = true;
    if (_timer != null) _timer!.cancel(); // 确保之前的计时器被取消
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (totalSeconds > 0) {
        setState(() {
          totalSeconds--;
        });
      } else {
        start.value = false;
        timer.cancel(); // 停止计时
      }
    });
  }

  // 停止倒计时
  void stopCountdown() {
    start.value = false;
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  _buildCard() {
    var style = TextStyle(fontSize: 20, color: Colors.white);
    if (start.value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text("Disuse".tr, style: style),
          Text(formattedTime, style: style.copyWith(fontSize: 30)),
          Text("See the world to your heart's content!".tr, style: style),
          FilledButton(onPressed: stopCountdown, child: Text("Stop timing".tr))
        ],
      );
    }

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Set the time to stop using".tr,
            style: TextStyle(fontSize: 20, color: Colors.white)),
        //创建一个选项，1分钟～60分钟
        Text("Drag the slider to select the number of minutes to stop".tr),
        Obx(() {
          return Slider(
            value: time.value,
            min: 1.0,
            max: 60.0,
            divisions: 60,
            label: "${time.value.round()}${'minutes'.tr}",
            onChanged: (value) {
              //显示模糊效果
              time.value = value;
            },
          );
        }),
        FilledButton(onPressed: startCountdown, child: Text("Start the clock".tr))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color(0xff222222),
        title: Text("Stopping".tr,
            style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                //背景高斯模糊
                image: DecorationImage(
                  image: AssetImage("assets/banner.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 模糊效果
            Obx(() {
              if (start.value) {
                return Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    // 控制模糊程度
                    child: Container(
                      color: Colors.black.withOpacity(0.2), // 半透明遮罩层
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
            Center(
              child: Container(
                width: 300,
                height: 250,
                padding: 10.padding,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(() => _buildCard()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
