import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musion/controller/opensMusic.dart';
import 'package:musion/database/databasefunctions/datafunction.dart';
import 'package:musion/screen/musicplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);
  List<Audio> audio = [];
  final controller = Get.put(DataFunction());
  AssetsAudioPlayer get player => AssetsAudioPlayer.withId('music');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text('Favorite'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Image.asset(
                'assests/images/fav.png',
                scale: 1.5,
              )),
              Column(
                children: [
                  GetBuilder<DataFunction>(
                    id: "delete",
                    builder: (controller) {
                      return favlist();
                    },
                  )
                ],
              ),
            ])),
      ),
    );
  }

  ValueListenableBuilder<Box<dynamic>> favlist() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('fav').listenable(),
      builder: (context, Box todos, _) {
        audio = [];
        List<dynamic> keys = todos.get('favsong');
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
        return (ListView.separated(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: keys.length,
          shrinkWrap: true,
          itemBuilder: (context, ind) {
            var title = keys[ind]['title'].toString();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  keys[ind]['title'].toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: QueryArtworkWidget(
                  nullArtworkWidget:
                      Image.asset('assests/images/apple-music-logo.png'),
                  id: keys[ind]['id'],
                  type: ArtworkType.AUDIO,
                ),
                subtitle: Text(
                  keys[ind]['artist'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  player.stop();
                  OpenPlayer().openPlayer(ind, audio);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MusicPlayer(audio: audio),
                    ),
                  );
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
                              'Delete Favorite',
                              style: TextStyle(color: Colors.black),
                            ),
                            actions: [
                              Column(
                                children: const [
                                  Text(
                                      "Are you sure you want to delete this song ?"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        keys.removeAt(ind);
                                        controller.update(["delete"]);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'No',
                                        style: TextStyle(color: Colors.black),
                                      ))
                                ],
                              )
                            ],
                          );
                        });
                  },
                ),
              ),
            );
          },
          separatorBuilder: (_, index) => const Divider(
            color: Colors.black,
          ),
        ));
      },
    );
  }
}
