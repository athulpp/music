import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musion/database/databasefunctions/datafunction.dart';

class Popupmenu extends StatelessWidget {
  final List<Audio> audios;
  final int index;

  Popupmenu({Key? key, required this.audios, required this.index})
      : super(key: key);
  final controller = Get.put(DataFunction());
  var playlistbox = Hive.box('playlist');
  final TextEditingController namecontroller = TextEditingController();
  // var playlistbox = Hive.box('playlist');
  String? title;
  @override
  Widget build(BuildContext context) {
    Box databox = Hive.box('songbox');
    var allsongsfromhive = databox.get('allsongs');
    var favoritesbox = Hive.box('fav');
    List<dynamic> favlists = favoritesbox.get('favsong');
    return PopupMenuButton(
      child: const Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      itemBuilder: (context) {
        return <PopupMenuItem>[
          PopupMenuItem(
            child: GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (
                      BuildContext context,
                    ) {
                      return ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          ListTile(
                            title: GestureDetector(
                              child: const Text(
                                '+ Add Playlist',
                                style: TextStyle(color: Colors.black),
                              ),
                              onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  List<dynamic> dummylist = [];
                                  return AlertDialog(
                                    backgroundColor: Colors.grey.shade300,
                                    title: const Text(
                                      'Give your playlist name',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    actions: [
                                      TextField(
                                        controller: namecontroller,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          hintText: 'Playlist Name',
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () async {
                                              if (namecontroller
                                                  .text.isNotEmpty) {
                                                title = namecontroller.text;
                                                title!.isNotEmpty
                                                    ? playlistbox.put(
                                                        title,
                                                        dummylist,
                                                      )
                                                    : playlistbox;

                                                Navigator.pop(context, 'OK');
                                                namecontroller.clear();
                                              }
                                            },
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ))
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          playlistbox.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No Songs in the playlist',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: ValueListenableBuilder(
                                    valueListenable:
                                        Hive.box('playlist').listenable(),
                                    builder: (context, Box playlist, _) {
                                      Box databox = Hive.box('songbox');
                                      var allsongsfromhive =
                                          databox.get('allsongs');

                                      List<dynamic> keys =
                                          playlist.keys.toList();

                                      return (ListView.builder(
                                        physics: const ScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: keys.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          List<dynamic> findsong =
                                              allsongsfromhive
                                                  .where(
                                                    (element) => element['id']
                                                        .toString()
                                                        .contains(
                                                          audios[index]
                                                              .metas
                                                              .id
                                                              .toString(),
                                                        ),
                                                  )
                                                  .toList();

                                          List<dynamic> playlists =
                                              playlistbox.get(keys[index]);

                                          return GestureDetector(
                                            onTap: () {},
                                            child: ListTile(
                                              leading: const Icon(
                                                Icons.list,
                                                color: Colors.black,
                                              ),
                                              title: Text(
                                                playlist.keyAt(index),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              trailing:
                                                  GetBuilder<DataFunction>(
                                                      id: "songadded",
                                                      builder: (controller) {
                                                        return TextButton(
                                                          onPressed: () {},
                                                          child: playlists
                                                                  .where((element) =>
                                                                      element['id']
                                                                          .toString() ==
                                                                      audios[index]
                                                                          .metas
                                                                          .id
                                                                          .toString())
                                                                  .isEmpty
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    playlists.add(
                                                                        findsong
                                                                            .first);
                                                                    playlistbox.put(
                                                                        keys[
                                                                            index],
                                                                        playlists);

                                                                    controller
                                                                        .update([
                                                                      "songadded"
                                                                    ]);
                                                                    Navigator.pop(
                                                                        context);
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                        content:
                                                                            Text('Song Added In Playlist'),
                                                                        duration:
                                                                            Duration(seconds: 1),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Add to Playlist',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                )
                                                              : GestureDetector(
                                                                  onTap: () {
                                                                    playlists.removeWhere((element) =>
                                                                        element['id']
                                                                            .toString() ==
                                                                        findsong
                                                                            .first['id']
                                                                            .toString());
                                                                    Navigator.pop(
                                                                        context);
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                        content:
                                                                            Text('Song Removed From Playlist'),
                                                                        duration:
                                                                            Duration(seconds: 1),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Remove From Playlist',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                        );
                                                      }),
                                            ),
                                          );
                                        },
                                      ));
                                    },
                                  ),
                                )
                        ],
                      );
                    },
                  );
                },
                child: const Text('Add to Playlist')),
            value: 'Add playlist',
          ),
          PopupMenuItem<String>(
            child: GestureDetector(
              onTap: () {
                List<dynamic> findsong = allsongsfromhive
                    .where(
                      (element) => element['id'].toString().contains(
                            audios[index].metas.id.toString(),
                          ),
                    )
                    .toList();
                favlists
                        .where((element) =>
                            element['id'].toString() ==
                            audios[index].metas.id.toString())
                        .isEmpty
                    ? favlists.add(findsong.elementAt(0))
                    : favlists.removeWhere((element) =>
                        element['id'].toString() ==
                        audios[index].metas.id.toString());

                favoritesbox.put('favsong', favlists);
                favlists
                        .where((element) =>
                            element['id'].toString() ==
                            audios[index].metas.id.toString())
                        .isEmpty
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Song Removed From Favorites'),
                          duration: Duration(seconds: 1),
                        ),
                      )
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Song Added To Favorites'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                Navigator.pop(context);
              },
              child: favlists
                      .where((element) =>
                          element['id'].toString() ==
                          audios[index].metas.id.toString())
                      .isEmpty
                  ? const Text('Add to Favorites')
                  : const Text('Remove From Favorites'),
            ),
          ),
        ];
      },
    );
  }
}
