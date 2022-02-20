import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DataFunction extends GetxController {
  @override
  void onInit() {
    requestpermission();
    super.onInit();
  }

  List<Audio> audio = [];
  List<SongModel> getsongs = [];
  List allsongsfromhive = [];
  List datasongs = [];
  Box databox = Hive.box('songbox');
  final OnAudioQuery _audioQuery = OnAudioQuery();
  Future<void> requestpermission() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }

    getsongs = await _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true);
    getsongs.forEach(
      (element) {
        datasongs.add(
          {
            'title': element.title,
            'artist': element.artist,
            'id': element.id,
            'uri': element.uri,
            'album': element.album,
            'duration': element.duration,
          },
        );

        databox.put('allsongs', datasongs);
        allsongsfromhive = databox.get('allsongs');
      },
    );
    for (var i = 0; i <= allsongsfromhive.length - 1; i++) {
      var newaudio = Audio.file(
        allsongsfromhive[i]['uri'].toString(),
        metas: Metas(
          id: allsongsfromhive[i]['id'].toString(),
          title: allsongsfromhive[i]['title'],
          album: allsongsfromhive[i]['album'],
          artist: allsongsfromhive[i]['artist'],
          image: MetasImage.file(
            allsongsfromhive[i]['uri'].toString(),
          ),
        ),
      );
      audio.add(newaudio);
    }
    update(['songs']);
  }

  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    update(["indexchange"]);
  }
}
