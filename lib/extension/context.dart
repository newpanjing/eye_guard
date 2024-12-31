import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ctr/router.dart';

extension ContextExtension on BuildContext {
  //主题色
  Color get primary => Theme.of(this).colorScheme.primary;

  to(dynamic page) {
    if (Get.width > 768) {
      RouterCtr.find().to(page);
    } else {
      Get.to(page);
    }
  }
}
