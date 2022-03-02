// ignore: file_names
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:musion/screen/musicplayer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class OpenPlayer {
  bool? onOff;
  getChoice() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    onOff = await sharedPreferences.getBool(userOnOfNotification);
  }

  AssetsAudioPlayer get player => AssetsAudioPlayer.withId('music');
  void openPlayer(int index, List<Audio> audios) async {
    await getChoice();
    await player
        .open(Playlist(audios: audios, startIndex: index),
            showNotification: onOff == null || onOff == true ? true : false,
            autoStart: true,
            loopMode: LoopMode.playlist,
            notificationSettings: const NotificationSettings(
              stopEnabled: false,
            ))
        .then((value) {
      Get.to(() => MusicPlayer(
            audio: audios,
          ));
    });
  }
}
