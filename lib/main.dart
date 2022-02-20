import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:musion/database/databasefunctions/datafunction.dart';

import 'package:musion/screen/home.dart';

import 'database/songsdata.dart';

// final routesCtrl = Get.put(RoutesController());
// final playerCtrl = Get.put(OpenAssetAudio());
Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DataSongModelAdapter());
  await Hive.openBox('songbox');
  // routesCtrl.Splash();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Music(),
    theme: ThemeData(primarySwatch: Colors.grey),
  ));
}

class Splash extends StatelessWidget {
  Splash({Key? key}) : super(key: key);

  final assetsAudioPlayer = AssetsAudioPlayer.withId('music');

  // Audio find(List<Audio> source, String fromPath) {
  //   return source.firstWhere((element) => element.path == fromPath);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assests/images/Splash_screen.png',
          scale: 5,
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}

class Init {
  // Init._();
  // static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}

class Music extends StatelessWidget {
  Music({Key? key}) : super(key: key);
  final controller = Get.put(DataFunction());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return MaterialApp(
                  home: Splash(), debugShowCheckedModeBanner: false);
            default:
              return GetBuilder<DataFunction>(
                id: "songs",
                builder: (controller ) {
                  return HomeScreen(
                    audio: controller.audio,
                  );
                },
              );
          }
        });
  }
}
