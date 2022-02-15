import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:musion/controller/musiccontroller.dart';

class OpenPlayer {
  AssetsAudioPlayer get player => AssetsAudioPlayer.withId('music');
  void openPlayer(int index, List<Audio> audios11) async {
    await player.open(
      Playlist(audios: audios11, startIndex: index),
      autoStart: true,
      loopMode: LoopMode.playlist,
      // notificationSettings: NotificationSettings(stopEnabled: false)
    );
  }
}
