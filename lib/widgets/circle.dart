import 'dart:async';

import 'package:eye_guard/widgets/circle_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleSport extends StatefulWidget {
  const CircleSport({Key? key}) : super(key: key);

  @override
  createState() => _CircleSportState();
}

class _CircleSportState extends State<CircleSport> {
  var isRuning = false;
  var text = "Start".tr;

  var time = 0;

  void _onAction() {
    if (!isRuning) {
      text = "Stop".tr;
      isRuning = true;
      grid.start();
    } else {
      text = "Start".tr;
      isRuning = false;
      grid.stop();
      time = 0;
    }
    setState(() {});
  }

  getText() {
    if (text == "") {
      if (isRuning) {
        text = "Stop".tr;
      } else {
        text = "Start".tr;
      }
    }

    return text;
  }

  @override
  void initState() {
    super.initState();

    //创建一个定时器1秒钟给time+1
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isRuning) {
        time++;
        setState(() {});
      }
    });
  }

  String getTimeString() {
    //把time转换成时分秒
    var hour = time ~/ 3600;
    var minute = (time - hour * 3600) ~/ 60;
    var second = time - hour * 3600 - minute * 60;
    return "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}";
  }

  CircleGrid grid = CircleGrid();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: 200,
        // height: 200,
        decoration: const BoxDecoration(
          color: Color(0xFF000003),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            //宽度最大
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getTimeString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilledButton(
                      onPressed: _onAction,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            isRuning ? Colors.red : Colors.deepPurple),
                      ),
                      child: Text(getText())),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SizedBox(width: double.infinity, child: grid),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
