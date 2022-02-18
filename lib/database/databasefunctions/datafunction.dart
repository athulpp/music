import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DataFunction extends GetxController {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('music');
  List<Audio> audio = [];
  List<SongModel> getsongs = [];
  List allsongsfromhive = [];
}
