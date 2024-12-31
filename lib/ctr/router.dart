import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../widgets/circle.dart';

class RouterCtr extends GetxController {
  Widget? current;
  @override
  onReady() {
    super.onReady();
    to(const CircleSport());
  }
  to(Widget page) {
    current = page;
    update();
  }

  static RouterCtr find() {
    return Get.find<RouterCtr>();
  }
}
