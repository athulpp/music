import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:musion/controller/musiccontroller.dart';

import 'package:musion/screen/home.dart';
import 'package:musion/screen/musicplayer.dart';
import 'package:musion/screen/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';

AssetsAudioPlayer player = AssetsAudioPlayer.withId('music');

class AllSongs extends StatefulWidget {
  AllSongs({Key? key}) : super(key: key);

  @override
  _AllSongsState createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  // OpenAssetAudio player=OpenAssetAudio();
  // List<Audio> playPlaylist = [];
  // late AssetsAudioPlayer _assetsAudioPlayer;
  // final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    // TODO: implement initState
    // player.open(Audio('assests/audios/music.mp3'),
    //     autoStart: true, showNotification: true);
    // player.open(Audio('assests/audios/Sorry Alan Walker 128 Kbps.mp3'));
    // super.initState();
  }
  // List<Audio> audios11 = [
  //   Audio("assests/audios/music.mp3",
  //       metas: Metas(
  //           id: '1',
  //           title: 'Din Din bhonsala',
  //           artist: 'Florent Champigny',
  //           image: const MetasImage.network(
  //               'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'))),
  //   Audio("assests/audios/Sorry Alan Walker 128 Kbps.mp3",
  //       metas: Metas(
  //         id: '2',
  //         title: 'Rocksss',
  //         artist: 'Florent Champignyffhjjjjj',
  //       )),
  //   Audio("assests/audios/Your Power Billie Eilish 128 Kbps.mp3",
  //       metas: Metas(
  //           id: '3',
  //           title: 'Your Power',
  //           artist: 'Billie Eilish',
  //           image: MetasImage.asset(
  //               'assests/images/album/Your-Power-Billie-Eilish-500-500.jpg'))),
  //   Audio("assests/audios/Electric Katy Perry 128 Kbps.mp3",
  //       metas: Metas(
  //         id: '4',
  //         title: 'Electric',
  //         artist: 'Electric',
  //       ))
  // ];

  // final audios = <Audio>[
  //   Audio(
  //     'assests/audios/music.mp3',
  //     //playSpeed: 2.0,
  //     metas: Metas(
  //       id: 'Rock',
  //       title: 'Rock',
  //       artist: 'Florent Champigny',
  //       album: 'RockAlbum',
  //       image: MetasImage.network(
  //           'https://static.radio.fr/images/broadcasts/cb/ef/2075/c300.png'),
  //     ),
  //   ),
  //   Audio(
  //     'assets/audios/2 country.mp3',
  //     metas: Metas(
  //       id: 'Country',
  //       title: 'Country',
  //       artist: 'Florent Champigny',
  //       album: 'CountryAlbum',
  //       image: MetasImage.asset('assets/images/country.jpg'),
  //     ),
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    player.open(
      Playlist(audios: audios11),
      autoStart: false,
      showNotification: true,
      loopMode: LoopMode.playlist,
      // seek: const Duration(seconds: 0, minutes: 0),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'All Songs',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SettingScreen());
            },
            icon: Icon(Icons.settings),
            color: Colors.black,
          )
        ],
      ),
      body: ListView.builder(
          itemCount: audios11.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              // onTap: () => Get.toNamed('/music'),
              onTap: () {
                // player.dispose();
                player.playlistPlayAtIndex(index);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MusicPlayer(
                              title: audios11[index].metas.title!,
                              artist: audios11[index].metas.artist!,
                              index: index,audio:audios11,
                            ))
                    // );
                    // final x = audios11;
                    // Get.to(MusicPlayer(,
                    //   index: index,
                    // ));
                    );
              },
              leading: QueryArtworkWidget(
                id: index,
                type: ArtworkType.AUDIO,
                artworkWidth: 300.0,
                artworkHeight: 300.0,
                nullArtworkWidget: Image.asset(
                  "assests/images/apple-music-logo.png",
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              // leading: CircleAvatar(backgroundImage: audios11[index].metas.image!,),
              title: Text(
                audios11[index].metas.title!,
              ),
              subtitle: Text(audios11[index].metas.artist!),
              trailing: PopupMenuButton(
                  color: Colors.white,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton(
                              onPressed: () {}, child: Text('Add to Playlist')),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: TextButton(
                              onPressed: () {},
                              child: Text('Add to Favorites')),
                          value: 2,
                        ),
                      ]),
            );
          }),
      // floatingActionButton: Container(
      //   width: MediaQuery.of(context).size.width,
      //   color: Colors.grey,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       IconButton(
      //           onPressed: () {},
      //           icon: Icon(
      //             Icons.first_page,
      //           )),
      //       IconButton(
      //           onPressed: () {},
      //           icon: Icon(
      //             Icons.play_arrow,
      //           )),
      //       IconButton(
      //           onPressed: () {},
      //           icon: Icon(
      //             Icons.last_page,
      //           )),
      //     ],
      //   ),
      // )
      bottomSheet: Opacity(
        opacity: 0.5,
        child: Container(
            color: Colors.black,
            child: ListTile(
              // onTap: () => Get.toNamed('/music'),
              // leading: CircleAvatar(
              //   backgroundColor: Colors.grey,
              // ),
              // title: Text(
              //   audios11[].metas.title!,
              //   style: TextStyle(color: Colors.white),
              // ),
              // subtitle: Text(
              //   'data',
              //   style: TextStyle(color: Colors.white),
              // ),
              title: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        print('object');
                        player.previous();
                      },
                      icon: Icon(
                        Icons.first_page,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        player.playOrPause();
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        player.next();
                      },
                      icon: Icon(
                        Icons.last_page,
                        color: Colors.white,
                      ))
                ],
              ),
            )),
      ),
    );
  }
}

Future<void> playPauseAudio() async {
  await player.playOrPause();
}

Future<void> playPrevious() async {
  await player.previous();
}

Future<void> playNext() async {
  await player.next();
}
