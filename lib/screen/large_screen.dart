import 'package:eye_guard/screen/index_screen.dart';
import 'package:eye_guard/widgets/circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ctr/router.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //左右布局
    return Scaffold(
      body: Row(
        children: [
          _buildLeft(context),
          VerticalDivider(
            width: 1,
            color: Colors.grey[900],
          ),
          _buildRight(context),
        ],
      ),
    );
  }

  //左侧布局
  Widget _buildLeft(BuildContext context) {
    return Container(
      width: 300,
      child: IndexScreen(),
    );
  }

  //右侧布局
  Widget _buildRight(BuildContext context) {
    return Expanded(
      child: GetBuilder<RouterCtr>(builder: (c) {
        return c.current ?? const Text("No page");
      }),
    );
  }
}
