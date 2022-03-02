import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musion/database/databasefunctions/datafunction.dart';
import 'package:musion/screen/allsongs.dart';
import 'package:musion/screen/favorites.dart';
import 'package:musion/screen/libary.dart';

import 'package:musion/screen/search.dart';
import 'package:musion/screen/settings.dart';

class HomeScreen extends StatelessWidget {
  final List<Audio> audio;
  HomeScreen({Key? key, required this.audio}) : super(key: key);

  final controller = Get.put((DataFunction));

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOption = [
      AllSongs(
        audios: audio,
      ),
      FavouriteScreen(),
      SearchScreen(
        audios: audio,
      ),
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
              ],
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(Icons.settings),
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
              onTap: controller.onItemTapped,
              currentIndex: controller.selectedIndex,
              // backgroundColor: Colors.black,
              iconSize: 35,

              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.yellow,
              unselectedIconTheme: const IconThemeData(color: Colors.yellow),
              selectedIconTheme: const IconThemeData(color: Colors.white),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.grey,
                    size: 28,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.grey,
                    size: 28,
                  ),
                  activeIcon: Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 28,
                  ),
                  activeIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.library_music,
                    color: Colors.grey,
                    size: 28,
                  ),
                  activeIcon: Icon(
                    Icons.library_music,
                    color: Colors.black,
                  ),
                  label: '',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
