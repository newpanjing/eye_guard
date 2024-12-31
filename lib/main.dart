import 'package:eye_guard/layout/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ctr/router.dart';
import 'local/messages.dart';
import 'screen/about.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(RouterCtr());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        //取消水波纹
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        //取消水波纹
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      translations: Messages(),
      //使用系统语言
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      home: const ResponsiveLayout(),
      routes: {
        '/about': (context) => const AboutPage(),
      },
    );
  }
}
