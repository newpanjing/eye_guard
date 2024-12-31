import 'package:eye_guard/extension/context.dart';
import 'package:eye_guard/screen/stop_screen.dart';
import 'package:eye_guard/widgets/circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_magic/magic.dart';
import 'package:get/get.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  _buildCard({String? title, String? desc, Widget? icon, Function? onTap}) {
    return Container(
      padding: 10.padding,
      decoration: BoxDecoration(
        color: context.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.primary, width: 2),
      ),
      child: Row(
        spacing: 10,
        children: [
          icon ?? Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title ?? ""),
                Text(
                  desc ?? "",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
          ),
          FilledButton(onPressed: () {
            onTap?.call();
          }, child: Text("GO"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? leading;
    if (GetPlatform.isMacOS) {
      leading = SizedBox(width: 90);
    }
    return Scaffold(
      appBar: AppBar(
        leading: leading,
        backgroundColor: Color(0xff222222),
        title: Text(
          "Eye Sport Guard",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: 10.padding,
        child: Column(
          spacing: 10,
          children: [
            10.hPadding,
            //banner图宣传
            _buildCard(
              icon: Icon(
                CupertinoIcons.eye,
                size: 30,
              ),
              title: "Eye Sport".tr,
              desc: "Relieve visual fatigue".tr,
              onTap: () {
                context.to(const CircleSport());
              },
            ),
            _buildCard(
              icon: Icon(
                CupertinoIcons.photo_on_rectangle,
                size: 30,
              ),
              onTap: () {
                context.to(const StopScreen());
              },
              title: "Take a break".tr,
              desc: "Stop and look into the distance".tr,
            )
          ],
        ),
      ),
    );
  }
}
