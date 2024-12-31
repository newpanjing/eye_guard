import 'package:eye_guard/screen/large_screen.dart';
import 'package:eye_guard/screen/small_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return context.width > 768 ? const LargeScreen() : const SmallScreen();
  }
}
