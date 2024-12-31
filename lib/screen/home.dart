import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/circle.dart';

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
