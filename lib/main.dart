import 'package:eye_guard/widgets/circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'about.dart';
import 'messages.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.white),
              onPressed: () {
                //导航到AboutPage
                Get.toNamed('/about');
              },
            )
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("title".tr,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onPrimary))),
      body:
          const CircleSport(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
