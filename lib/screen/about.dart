import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: SelectableText("about_desc".tr,
                style: const TextStyle(color: Colors.white, fontSize: 16.0)),
          ),
        ),
      ),
    );
  }
}
