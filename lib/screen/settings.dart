import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musion/database/databasefunctions/datafunction.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final controller = Get.put(DataFunction());

  setchoice(bool value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool(userOnOfNotification, value);
  }

  final player = AssetsAudioPlayer();
  // bool a = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(children: [
              ListTile(
                leading: const Icon(
                  Icons.notifications,
                ),
                title: const Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                trailing: GetBuilder<DataFunction>(
                    id: 'Switch',
                    builder: (controller) {
                      return Switch(
                        activeColor: Colors.grey,
                        value: controller.onOff,
                        onChanged: (value) {
                          controller.onOff = value;
                          setchoice(value);
                          controller.update(["Switch"]);
                        },
                        inactiveTrackColor: Colors.red,
                        activeTrackColor: Colors.green,
                      );
                    }),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text(
                  'Privacy Policies',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('User data safe with this application '),
              ),
              const Divider(),
              // ListTile(
              //   leading: Icon(Icons.verified_sharp),
              //   title: Text('Version'),
              //   subtitle: Text('1.7.1'),
              // ),
              const Divider(),
              ListTile(
                onTap: () => {},
                leading: const Icon(Icons.confirmation_num),
                title: const Text('Terms and conditions'),
                subtitle:const  Text('view more'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info),
                onTap: () => showAboutDialog(
                    applicationIcon: Image.asset(
                      'assests/images/Splash_screen.png',
                      width: 70,
                      height: 70,
                    ),
                    context: context,
                    applicationName: 'Musion',
                    applicationVersion: '1.7.0',
                    children: [
                      const Text(
                          "Musion is a Offline Music Player Created by Athul"),
                    ]),
                title: const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Version 1.7.0',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 50,
              )
            ],
          )
        ],
      ),
    );
  }
}
