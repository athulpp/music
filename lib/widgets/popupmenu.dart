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
      child: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      itemBuilder: (context) {
        return <PopupMenuItem<String>>[
          PopupMenuItem<String>(
            child: GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    ListTile(
                                      title: GestureDetector(
                                        child: Text(
                                          '+ Add Playlist',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onTap: () => showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            List<dynamic> dummylist = [];
                                            return AlertDialog(
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              title: Text(
                                                'Give your playlist name',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              actions: [
                                                TextField(
                                                  controller: namecontroller,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Playlist Name',
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        if (namecontroller
                                                            .text.isNotEmpty) {
                                                          title = namecontroller
                                                              .text;
                                                          title!.isNotEmpty
                                                              ? playlistbox.put(
                                                                  title,
                                                                  dummylist,
                                                                )
                                                              : playlistbox;

                                                          Navigator.pop(
                                                              context, 'OK');
                                                          namecontroller
                                                              .clear();
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
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
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
                                                  Hive.box('playlist')
                                                      .listenable(),
                                              builder:
                                                  (context, Box playlist, _) {
                                                Box databox =
                                                    Hive.box('songbox');
                                                var allsongsfromhive =
                                                    databox.get('allsongs');

                                                List<dynamic> keys =
                                                    playlist.keys.toList();

                                                return (ListView.separated(
                                                  physics:
                                                      const ScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: keys.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    List<dynamic> findsong =
                                                        allsongsfromhive
                                                            .where(
                                                              (element) =>
                                                                  element['id']
                                                                      .toString()
                                                                      .contains(
                                                                        audios[index]
                                                                            .metas
                                                                            .id
                                                                            .toString(),
                                                                      ),
                                                            )
                                                            .toList();
                                                    // print(allsongsfromhive);
                                                    List<dynamic> playlists =
                                                        playlistbox
                                                            .get(keys[index]);
                                                    print(keys);
                                                    // print(playlistbox);
                                                    return GestureDetector(
                                                      onTap: () {},
                                                      child: ListTile(
                                                        leading: Icon(
                                                          Icons.list,
                                                          color: Colors.black,
                                                        ),
                                                        title: Text(
                                                          playlist.keyAt(index),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        trailing: GetBuilder<
                                                                DataFunction>(
                                                            id: "songadded",
                                                            builder:
                                                                (controller) {
                                                              return TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child: playlists
                                                                        .where((element) =>
                                                                            element['id'].toString() ==
                                                                            audios[index].metas.id.toString())
                                                                        .isEmpty
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          playlists
                                                                              .add(findsong.first);
                                                                          playlistbox.put(
                                                                              keys[index],
                                                                              playlists);
                                                                          // print(
                                                                          //     playlistbox);

                                                                          controller
                                                                              .update([
                                                                            "songadded"
                                                                          ]);
                                                                          Navigator.pop(
                                                                              context);
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: const Text('Song Added In Playlist'),
                                                                              duration: const Duration(seconds: 1),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Add to Playlist',
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        ),
                                                                      )
                                                                    : GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          playlists.removeWhere((element) =>
                                                                              element['id'].toString() ==
                                                                              findsong.first['id'].toString());
                                                                          Navigator.pop(
                                                                              context);
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: const Text('Song Removed From Playlist'),
                                                                              duration: const Duration(seconds: 1),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Remove From Playlist',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                              );
                                                            }),
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (_, index) => Divider(
                                                    color: Colors.black,
                                                  ),
                                                ));
                                              },
                                            ),
                                          )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: new Text('Add to Playlist')),
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
                        SnackBar(
                          content: const Text('Song Removed From Favorites'),
                          duration: const Duration(seconds: 1),
                        ),
                      )
                    : ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Song Added To Favorites'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                Navigator.pop(context);
              },
              child: favlists
                      .where((element) =>
                          element['id'].toString() ==
                          audios[index].metas.id.toString())
                      .isEmpty
                  ? new Text('Add to Favorites')
                  : new Text('Remove From Favorites'),
            ),
            // value: 'Favorites',
            // onTap: () {},
          ),
        ];
      },
    );
  }
}

// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:musicsample/controller/controller.dart';
// import 'package:musion/database/databasefunctions/datafunction.dart';

// class Popupmenu extends StatelessWidget {
//   final List<Audio> audios;
//   final int index;
//   Popupmenu({Key? key, required this.audios, required this.index})
//       : super(key: key);
//   final controller = Get.put(DataFunction());

//   var playlistbox = Hive.box('playlist');

//   final TextEditingController namecontroller = TextEditingController();
//   String? title;

//   @override
//   Widget build(BuildContext context) {
//     Box databox = Hive.box('songbox');
//     var allsongsfromhive = databox.get('allsongs');
//     var favoritesbox = Hive.box('fav');
//     List<dynamic> favlists = favoritesbox.get('favsong');
//     return PopupMenuButton(
//       child: Icon(
//         Icons.more_vert,
//         color: Colors.black,
//       ),
//       itemBuilder: (context) {
//         return <PopupMenuItem<String>>[
//           new PopupMenuItem<String>(
//             child: GestureDetector(
//                 onTap: () {
//                   showModalBottomSheet<void>(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return Container(
//                         color: Colors.black,
//                         child: Center(
//                           child: Column(
//                             children: <Widget>[
//                               ListView(
//                                 shrinkWrap: true,
//                                 scrollDirection: Axis.vertical,
//                                 children: [
//                                   ListTile(
//                                     title: GestureDetector(
//                                       child: Text(
//                                         '+ Add Playlist',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       onTap: () => showDialog<String>(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           List<dynamic> dummylist = [];
//                                           return AlertDialog(
//                                             backgroundColor: Colors.black,
//                                             title: Text(
//                                               'Create New Playlist',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                             actions: [
//                                               TextField(
//                                                 controller: namecontroller,
//                                                 decoration: InputDecoration(
//                                                   filled: true,
//                                                   fillColor: Colors.white,
//                                                   border: OutlineInputBorder(),
//                                                   hintText: 'Playlist Name',
//                                                 ),
//                                               ),
//                                               TextButton(
//                                                 onPressed: () async {
//                                                   if (namecontroller
//                                                       .text.isNotEmpty) {
//                                                     title = namecontroller.text;
//                                                     title!.isNotEmpty
//                                                         ? playlistbox.put(
//                                                             title,
//                                                             dummylist,
//                                                           )
//                                                         : playlistbox;
//                                                     //  setState(() {});
//                                                     Navigator.pop(
//                                                         context, 'OK');
//                                                     namecontroller.clear();
//                                                   }
//                                                 },
//                                                 child: const Text(
//                                                   'OK',
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   playlistbox.isEmpty
//                                       ? Text(
//                                           'No Songs here now',
//                                           style: TextStyle(color: Colors.white),
//                                         )
//                                       : SingleChildScrollView(
//                                           scrollDirection: Axis.vertical,
//                                           child: ValueListenableBuilder(
//                                             valueListenable:
//                                                 Hive.box('playlist')
//                                                     .listenable(),
//                                             builder:
//                                                 (context, Box playlist, _) {
//                                               Box databox = Hive.box('songbox');
//                                               var allsongsfromhive =
//                                                   databox.get('allsongs');

//                                               List<dynamic> keys =
//                                                   playlist.keys.toList();

//                                               return (ListView.separated(
//                                                 physics: ScrollPhysics(),
//                                                 scrollDirection: Axis.vertical,
//                                                 itemCount: keys.length,
//                                                 shrinkWrap: true,
//                                                 itemBuilder: (context, ind) {
//                                                   List<dynamic> findsong =
//                                                       allsongsfromhive
//                                                           .where(
//                                                             (element) =>
//                                                                 element['id']
//                                                                     .toString()
//                                                                     .contains(
//                                                                       audios[index]
//                                                                           .metas
//                                                                           .id
//                                                                           .toString(),
//                                                                     ),
//                                                           )
//                                                           .toList();
//                                                   List<dynamic> playlists =
//                                                       playlistbox
//                                                           .get(keys[ind]);
//                                                   return GestureDetector(
//                                                     onTap: () {},
//                                                     child: ListTile(
//                                                       leading: Icon(
//                                                         Icons.playlist_play,
//                                                         color: Colors.white,
//                                                       ),
//                                                       title: Text(
//                                                         playlist.keyAt(ind),
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.white),
//                                                       ),
//                                                       trailing:
//                                                           GetBuilder<
//                                                                   DataFunction>(
//                                                               id: "songadded",
//                                                               builder:
//                                                                   (controller) {
//                                                                 return TextButton(
//                                                                   onPressed:
//                                                                       () {},
//                                                                   child: playlists
//                                                                           .where((element) =>
//                                                                               element['id'].toString() ==
//                                                                               audios[index].metas.id.toString())
//                                                                           .isEmpty
//                                                                       ? GestureDetector(
//                                                                           onTap:
//                                                                               () {
//                                                                             playlists.add(findsong.first);
//                                                                             playlistbox.put(keys[ind],
//                                                                                 playlists);

//                                                                             controller.update([
//                                                                               "songadded"
//                                                                             ]);
//                                                                             Navigator.pop(context);
//                                                                             ScaffoldMessenger.of(context).showSnackBar(
//                                                                               SnackBar(
//                                                                                 content: const Text('Song Added In Playlist'),
//                                                                                 duration: const Duration(seconds: 1),
//                                                                               ),
//                                                                             );
//                                                                           },
//                                                                           child:
//                                                                               Text(
//                                                                             'Add to Playlist',
//                                                                             style:
//                                                                                 TextStyle(color: Colors.white),
//                                                                           ),
//                                                                         )
//                                                                       : GestureDetector(
//                                                                           onTap:
//                                                                               () {
//                                                                             playlists.removeWhere((element) =>
//                                                                                 element['id'].toString() ==
//                                                                                 findsong.first['id'].toString());
//                                                                             Navigator.pop(context);
//                                                                             ScaffoldMessenger.of(context).showSnackBar(
//                                                                               SnackBar(
//                                                                                 content: const Text('Song Removed From Playlist'),
//                                                                                 duration: const Duration(seconds: 1),
//                                                                               ),
//                                                                             );
//                                                                           },
//                                                                           child:
//                                                                               Text(
//                                                                             'Remove From Playlist',
//                                                                             style:
//                                                                                 TextStyle(color: Colors.white),
//                                                                           ),
//                                                                         ),
//                                                                 );
//                                                               }),
//                                                     ),
//                                                   );
//                                                 },
//                                                 separatorBuilder: (_, index) =>
//                                                     Divider(
//                                                   color: Colors.white,
//                                                 ),
//                                               ));
//                                             },
//                                           ),
//                                         )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 child: new Text('Add to Playlist')),
//             value: 'Add playlist',
//           ),
//           new PopupMenuItem<String>(
//             child: GestureDetector(
//               onTap: () {
//                 List<dynamic> findsong = allsongsfromhive
//                     .where(
//                       (element) => element['id'].toString().contains(
//                             audios[index].metas.id.toString(),
//                           ),
//                     )
//                     .toList();
//                 favlists
//                         .where((element) =>
//                             element['id'].toString() ==
//                             audios[index].metas.id.toString())
//                         .isEmpty
//                     ? favlists.add(findsong.first)
//                     : favlists.removeWhere((element) =>
//                         element['id'].toString() ==
//                         audios[index].metas.id.toString());

//                 favoritesbox.put('favsong', favlists);
//                 favlists
//                         .where((element) =>
//                             element['id'].toString() ==
//                             audios[index].metas.id.toString())
//                         .isEmpty
//                     ? ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: const Text('Song Removed From Favorites'),
//                           duration: const Duration(seconds: 1),
//                         ),
//                       )
//                     : ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: const Text('Song Added To Favorites'),
//                           duration: const Duration(seconds: 1),
//                         ),
//                       );
//                 Navigator.pop(context);
//               },
//               child: favlists
//                       .where((element) =>
//                           element['id'].toString() ==
//                           audios[index].metas.id.toString())
//                       .isEmpty
//                   ? new Text('Add to Favorites')
//                   : new Text('Remove From Favorites'),
//             ),
//             // value: 'Favorites',
//             // onTap: () {},
//           ),
//         ];
//       },
//     );
//   }
// }
