import 'package:eye_guard/widgets/circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screen/about.dart';
import 'local/messages.dart';
import 'screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true
      ),
      translations: Messages(),
      //使用系统语言
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: {
        '/about': (context) => const AboutPage(),
      },
    );
  }
}
