import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musion/database/databasefunctions/datafunction.dart';
import 'package:musion/screen/album.dart';

class LibaryScreen extends StatelessWidget {
  final List<Audio> audios;
  LibaryScreen({Key? key, required this.audios}) : super(key: key);
  final controller = Get.put(DataFunction());
  var playlistbox = Hive.box('playlist');

  final TextEditingController namecontroller = TextEditingController();
  String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              title: GestureDetector(
                child: Center(
                  child: Container(
                    color: Colors.grey,
                    width: 150,
                    height: 20,
                    child: const Text(
                      'Create New Playlist',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    List<dynamic> dummylist = [];
                    return AlertDialog(
                      backgroundColor: Colors.grey,
                      title: const Text(
                        'Create New Playlist',
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                var keys = playlistbox.keys.toList();

                                if (namecontroller != null) {
                                  title = namecontroller.text;
                                  keys
                                          .where((element) => element == title)
                                          .isEmpty
                                      ? title!.isNotEmpty
                                          ? playlistbox.put(
                                              title,
                                              dummylist,
                                            )
                                          : playlistbox
                                      : ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'This name is already exist'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                  // controller.update(["edited"]);
                                  // Get.back();
                                  // namecontroller.clear();
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
                                  style: TextStyle(color: Colors.black),
                                ))
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            GetBuilder<DataFunction>(builder: (Controller) {
              return ValueListenableBuilder(
                valueListenable: Hive.box('playlist').listenable(),
                builder: (context, Box playlistname, _) {
                  return (ListView.separated(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: playlistname.keys.length,
                    shrinkWrap: true,
                    itemBuilder: (context, ind) {
                      return ListTile(
                        onTap: () {
                          Get.to(
                            () => PlaylistScreen(
                                title: playlistname.keyAt(ind), audios: audios),
                          );
                        },
                        onLongPress: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                title: const Text(
                                  'Give Your Playlist Name',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                actions: [
                                  TextField(
                                    controller: namecontroller,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.black,
                                      border: const OutlineInputBorder(),
                                      hintText: playlistname.keyAt(ind),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      var y = playlistbox
                                          .get(playlistname.keyAt(ind));
                                      var keys = playlistbox.keys.toList();
                                      if (namecontroller.text.isNotEmpty) {
                                        title = namecontroller.text;
                                        keys
                                                .where((element) =>
                                                    element == title)
                                                .isEmpty
                                            ? title!.isNotEmpty
                                                ? playlistbox.put(
                                                    title,
                                                    y,
                                                  )
                                                : playlistbox
                                            : ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'This name is already exist'),
                                                  duration:
                                                      Duration(seconds: 1),
                                                ),
                                              );
                                        keys
                                                .where((element) =>
                                                    element == title)
                                                .isEmpty
                                            ? title!.isNotEmpty
                                                ? playlistbox.delete(
                                                    playlistname.keyAt(ind),
                                                  )
                                                : playlistbox
                                            : playlistbox;
                                      }
                                      controller.update();
                                      Navigator.pop(context, 'OK');
                                      namecontroller.clear();
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        leading: const Icon(
                          Icons.playlist_play,
                          color: Colors.black,
                        ),
                        title: playlistname.isEmpty
                            ? const Text(
                                "No",
                                style: TextStyle(color: Colors.black),
                              )
                            : Text(
                                playlistname.keyAt(ind),
                                style: const TextStyle(color: Colors.black),
                              ),
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
                                        'Delete Playlist',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      actions: [
                                        Column(
                                          children: [
                                            const Text(
                                                'Do you want to delete  this Playlist'),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      playlistname
                                                          .deleteAt(ind);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
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
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            }),
                      );
                    },
                    separatorBuilder: (_, index) => const Divider(
                      color: Colors.black,
                    ),
                  ));
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
