import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musion/screen/allsongs.dart';

List<Audio> audios11 = [
  Audio("assests/audios/music.mp3",
      metas: Metas(
          title: 'Din Din bhonsala',
          artist: 'Florent Champigny',
          image: const MetasImage.network(
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'))),
  Audio("assests/audios/Sorry Alan Walker 128 Kbps.mp3",
      metas: Metas(
        title: 'Rocksss',
        artist: 'Florent Champignyffhjjjjj',
      )),
  Audio("assests/audios/Your Power Billie Eilish 128 Kbps.mp3",
      metas: Metas(
          title: 'Your Power',
          artist: 'Billie Eilish',
          image: MetasImage.asset(
              'assests/images/album/Your-Power-Billie-Eilish-500-500.jpg'))),
  Audio("assests/audios/Electric Katy Perry 128 Kbps.mp3",
      metas: Metas(
        id: '4',
        title: 'Electric',
        artist: 'Electric',
      ))
];


class OpenAssetAudio extends GetxController {
  RxBool isPlaying = false.obs;
  late Stream<bool> isAudioPlayerPlaying;
  // late Stream<Playing?> currentStatus;
  // RxString songTitle = "UNKNOWN TITLE".obs;
  // RxString songArtists = "UNKNOWN ARTISTS".obs;
  // RxInt songId = 0.obs;

  // player.open(
  //     Playlist(audios: audios11),
  //     autoStart: false,
  //     showNotification: true,
  //     loopMode: LoopMode.none,
  //     seek: Duration(seconds: 0),
  //   );
  // List<Audio> allsong;
  // int index?;
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
  //               'assests/images/album/Your-Power-Billie-Eilish-500-500.jpg')))
  // ];
  // bool? notify;
  // Future<bool?> setNotifyValue() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   notify = await prefs.getBool("switchState");

  //   return notify;
  // }

  // OpenAssetAudio({required this.audios11,required this.index});
  // final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");
  // openAsset({List<Audio>? audios, required int index}) async {
  //   // notify = await setNotifyValue();
  //   audioPlayer.open(
  //     Playlist(audios: [Audio("assests/audios/music.mp3",
  //           metas: Metas(
  //             id: 'Rock',
  //             title: 'Rock',
  //             artist: 'Florent Champigny',
  //           ))],startIndex: index));
  //     // showNotification: notify == null || notify == true ? true : false,
  //     notificationSettings: NotificationSettings(
  //       stopEnabled: false,

  //     );

  // }

//  void open() {}
  Widget seekBarWidget(BuildContext ctx) {
    return player.builderRealtimePlayingInfos(
      builder: (ctx, infos) {
        Duration cPos = infos.currentPosition;
        Duration total = infos.duration;
        return Container(
          width: 300,
          child: ProgressBar(
            progress: cPos,
            total: total,
            progressBarColor: Colors.grey,
            onSeek: (to) {
              player.seek(to);
            },
          ),
        );
      },
    );
  }
}
