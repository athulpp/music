import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musion/controller/musiccontroller.dart';
import 'package:musion/screen/allsongs.dart';
import 'package:musion/screen/favorites.dart';
import 'package:musion/screen/libary.dart';
import 'package:musion/screen/musicplayer.dart';
import 'package:musion/screen/search.dart';
import 'package:musion/screen/settings.dart';
import 'package:musion/screen/splash.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedindex = 0;
  PageController _pageController = PageController();
  List<Widget> _screens = [
    AllSongs(),
    FavouriteScreen(),
    SearchScreen(),
    LibaryScreen()
  ];
  void _onPageChanged(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  void onItemTapped(int selectedIndex) {
    print(selectedIndex);
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          // physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTapped,
          backgroundColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: selectedindex == 0 ? Colors.black : Colors.white,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border,
                  color: selectedindex == 1 ? Colors.black : Colors.white,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: selectedindex == 2 ? Colors.black : Colors.white,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.folder,
                  color: selectedindex == 3 ? Colors.black : Colors.white,
                ),
                label: '')
          ],
        ));
  }
}
