import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musion/controller/opensMusic.dart';
import 'package:musion/database/databasefunctions/datafunction.dart';
import 'package:musion/screen/musicplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistScreen extends StatelessWidget {
  List<Audio> audios;
  PlaylistScreen({Key? key, required this.audios, required this.title})
      : super(key: key);
  final String title;
  AssetsAudioPlayer get player => AssetsAudioPlayer.withId('music');
  final controller = Get.put(DataFunction());
  List<Audio> audio = [];
  List<dynamic> a = [];
  dynamic playlistbox = Hive.box('playlist');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Image.asset(
                'assests/images/album.png',
                scale: 10,
              )),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Box databox = Hive.box('songbox');
                  List<dynamic> allsongsfromhive = databox.get('allsongs');
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return bottam(
                        name: title,
                      );
                    },
                  );
                },
                child: Container(
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: const Text('Add Songs Into this Playlist')),
              ),
              playlistList(),
            ],
          ),
        ),
      ),
    );
  }

  ValueListenableBuilder<Box<dynamic>> playlistList() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('playlist').listenable(),
      builder: (context, Box todos, _) {
        audio = [];
        List<dynamic> keys = todos.get(title);
        for (var i = 0; i <= keys.length - 1; i++) {
          Audio? newaudio = Audio.file(
            keys[i]['uri'].toString(),
            metas: Metas(
              id: keys[i]['id'].toString(),
              title: keys[i]['title'],
              album: keys[i]['album'],
              artist: keys[i]['artist'],
              image: MetasImage.file(
                keys[i]['uri'].toString(),
              ),
            ),
          );

          audio.add(newaudio);
        }
        return GetBuilder<DataFunction>(
          id: "deleted",
          builder: (contreller) {
            return (ListView.separated(
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: keys.length,
              shrinkWrap: true,
              itemBuilder: (context, ind) {
                var title = (keys[ind]['title']);
                return ListTile(
                  title: Text(keys[ind]['title'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1),
                  leading: QueryArtworkWidget(
                    nullArtworkWidget:
                        Image.asset('assests/images/apple-music-logo.png'),
                    id: keys[ind]['id'],
                    type: ArtworkType.AUDIO,
                  ),
                  subtitle: Text(keys[ind]['artist'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2),
                  onTap: () {
                    player.stop();
                    OpenPlayer().openPlayer(ind, audio);
                    Get.to(() => MusicPlayer(
                          audio: audio,
                        ));
                  },
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey.shade300,
                              title: const Text(
                                'Delete this Song',
                                style: TextStyle(color: Colors.black),
                              ),
                              actions: [
                                Column(
                                  children: [
                                    const Text(
                                        'Do you want to delete  this Song'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            keys.removeAt(ind);
                                            controller.update(["deleted"]);
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Yes',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            );
                          }
                          // keys.removeAt(ind);
                          // controller.update(["deleted"]);
                          );
                    },
                  ),
                );
              },
              separatorBuilder: (_, index) => const Divider(
                color: Colors.white,
              ),
            ));
          },
        );
      },
    );
  }
}

class bottam extends StatelessWidget {
  bottam({Key? key, required this.name}) : super(key: key);
  final name;
  final controller = Get.put(DataFunction());
  Box playlistbox = Hive.box('playlist');
  List<dynamic> a = [];
  @override
  Widget build(BuildContext context) {
    Box databox = Hive.box('songbox');
    List<dynamic> allsongsfromhive = databox.get('allsongs');
    List<dynamic> playlist = playlistbox.get(name);
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: allsongsfromhive.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: QueryArtworkWidget(
            nullArtworkWidget:
                Image.asset('assests/images/apple-music-logo.png'),
            id: allsongsfromhive[index]['id'],
            type: ArtworkType.AUDIO,
          ),
          title: Text(
            allsongsfromhive[index]['title'],
            style: const TextStyle(color: Colors.black),
          ),
          trailing: GetBuilder<DataFunction>(
            id: "playlist",
            builder: (controller) {
              return playlist
                      .where((element) =>
                          element["id"].toString() ==
                          allsongsfromhive[index]["id"].toString())
                      .isEmpty
                  ? GestureDetector(
                      onTap: () {
                        playlist.add(allsongsfromhive[index]);
                        playlistbox.put(name, playlist);
                        controller.update(["playlist"]);
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        playlist.removeWhere((element) =>
                            element['id'].toString() ==
                            allsongsfromhive[index]['id'].toString());
                        playlistbox.put(name, playlist);
                        controller.update(["playlist"]);
                      },
                      child: const Icon(
                        Icons.check_box,
                        color: Colors.black,
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}
