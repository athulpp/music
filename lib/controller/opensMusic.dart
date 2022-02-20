// ignore: file_names
import 'package:assets_audio_player/assets_audio_player.dart';

class OpenPlayer {
  AssetsAudioPlayer get player => AssetsAudioPlayer.withId('music');
  void openPlayer(int index, List<Audio> audios) async {
    await player.open(Playlist(audios: audios, startIndex: index),
        showNotification: true,
        autoStart: true,
        loopMode: LoopMode.playlist,
        notificationSettings: NotificationSettings(stopEnabled: false));
  }
}
