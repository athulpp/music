import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musion/controller/musiccontroller.dart';
import 'package:musion/routes/routes.dart';
import 'package:musion/screen/home.dart';
import 'package:musion/screen/splash.dart';

import 'controller/routescontrol.dart';
import 'database/songsdata.dart';

final routesCtrl = Get.put(RoutesController());
// final playerCtrl = Get.put(OpenAssetAudio());
Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DataSongModelAdapter());
  routesCtrl.Splash();
  runApp(Music());
}

class Music extends StatelessWidget {
  const Music({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      initialRoute: '/splash',
      getPages: appRoutes,
      home: HomeScreen(),
    );
  }
}
