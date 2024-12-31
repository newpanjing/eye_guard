import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/list_tile.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151218),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),

            //支持
            ListTileSection(header: Text('Support us'.tr), children: [
              ListTileItem(
                leading: const Icon(Icons.star_border),
                title: Text('Give us a grade'.tr),
                trailing: const CupertinoListTileChevron(),
                onTap: () {
                  launchUrl(Uri.parse(
                      "itms-apps://itunes.apple.com/app/6446052957?action=write-review"));
                },
              ), ListTileItem(
                leading: const Icon(Icons.list),
                title: Text('More Apps'.tr),
                trailing: const CupertinoListTileChevron(),
                onTap: () {
                  launchUrl(Uri.parse(
                      "https://apps.apple.com/us/developer/%E6%95%AC-%E6%BD%98/id1630712468"));
                },
              ),
            ]),


            //最近更新和官网
            ListTileSection(children: [

              ListTileItem(
                leading: const Icon(Icons.open_in_browser),
                title: Text('www.noondot.com'.tr),
                trailing: const CupertinoListTileChevron(),
                onTap: () {
                  launchUrl(Uri.parse('https://www.noondot.com'));
                },
              )
            ]),

            //版本号和备案号
            ListTileSection(children: [
              ListTileItem(
                leading: const Icon(Icons.info),
                title: Text('Version'.tr),
                trailing: Text(
                  "v1.1",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),

            ]),

          ],
        ),
      ),
    );
  }
}
