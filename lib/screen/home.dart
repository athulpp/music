import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musion/controller/musiccontroller.dart';
import 'package:musion/database/databasefunctions/datafunction.dart';
import 'package:musion/screen/allsongs.dart';
import 'package:musion/screen/favorites.dart';
import 'package:musion/screen/libary.dart';
import 'package:musion/screen/musicplayer.dart';
import 'package:musion/screen/search.dart';
import 'package:musion/screen/settings.dart';
import 'package:musion/screen/splash.dart';

class HomeScreen extends StatelessWidget {
  final List<Audio> audio;
  HomeScreen({Key? key, required this.audio}) : super(key: key);

  final controller = Get.put((DataFunction));

  // AssetsAudioPlayer get player => AssetsAudioPlayer.withId('music');
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOption = [
      AllSongs(
        audios: audio,
      ),
      FavouriteScreen(),
      SearchScreen(),
      LibaryScreen(
        audios: audio,
      )
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Image.asset(
            'assests/images/Splash_screen.png',
            scale: 0.2,
          ),
          title: const Text(
            'Musions',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                // Shadow(
                //   offset: Offset(10.0, 10.0),
                //   blurRadius: 8.0,
                //   color: Color.fromARGB(125, 0, 0, 255),
                // ),
              ],
            ),
          ),

          centerTitle: true,
          // backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Get.to(() => SettingScreen());
                }),
          ],
        ),
        body: GetBuilder<DataFunction>(
          init: DataFunction(),
          id: "indexchange",
          builder: (controller) {
            return _widgetOption[controller.selectedIndex];
          },
        ),
        bottomNavigationBar: GetBuilder<DataFunction>(
          id: "indexchange",
          builder: (controller) {
            return BottomNavigationBar(
              fixedColor: Colors.amber,

              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.library_music,
                    color: Colors.black,
                  ),
                  label: '',
                ),
              ],
              onTap: controller.onItemTapped,
              currentIndex: controller.selectedIndex,
              // selectedItemColor: Colors.green,
              selectedIconTheme: IconThemeData(color: Colors.amber, size: 34),
            );
          },
        ),
      ),
    );
  }
}
