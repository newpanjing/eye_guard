import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //多行文本
    var text = '''
Eye Guard is an APP for eye protection.

The idea is to use small white circles to move, so that the eye can follow.

This can effectively move the eyeball, so that the blood flow around the eye is more full, so as to relieve eye fatigue.

The principle is shared by an eye hospital in China.

Note: Software cannot fundamentally solve your eye problem, if you have eye discomfort, please seek medical attention as soon as possible.

Email: newpanjing@icloud.com
''';

    var width = 0.0;
    if (GetPlatform.isMacOS) {
      width = 250.0;
    }
    return Scaffold(
      appBar: AppBar(
          //返回按钮间距
          leadingWidth: width,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("About".tr,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onPrimary))),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SelectableText(text,
                style: const TextStyle(color: Colors.white, fontSize: 16.0)),
          ),
        ),
      ),
    );
  }
}
