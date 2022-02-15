import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musion/screen/album.dart';
import 'package:musion/screen/favorites.dart';
import 'package:musion/screen/newplaylist.dart';

class LibaryScreen extends StatelessWidget {
  const LibaryScreen({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }
  CreateAlertDialouge(BuildContext context) {
    TextEditingController playlistname = TextEditingController();
    return AlertDialog(
      title: Text('Enter The new Playlist Name'),
      content: TextField(
        controller: playlistname,
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop(playlistname.text.toString());
          },
          elevation: 5,
          child: Text('OK'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'Libary',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Divider(
                thickness: 2,
              ),
              ListTile(
                onTap: () => Get.toNamed('/newplay'),
                // AlertDialog(
                //   title: Text('Enter New Playlist name'),
                // );
                // CreateAlertDialouge(context),

                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                ),
                title: Text('Create Playlist'),
              ),
              // ListTile(
              //   onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const FavouriteScreen())),
              //   leading: CircleAvatar(
              //     backgroundColor: Colors.green,
              //   ),
              //   title: Text('Favorites'),
              // )
            ],
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 2,
          ),
          Flexible(
            // flex: 8,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) => ListTile(
                onTap: () => {
                  index,
                  print(index),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AlbumScreen()))
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
                title: Text('Playlists $index'),
                trailing:
                    // IconButton(onPressed: () {}, icon: Icon(Icons.delete)
                    // )
                    PopupMenuButton(
                        color: Colors.white,
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Remove'),
                                              content:
                                                  Text('Do you want Remove'),
                                              actions: <Widget>[
                                                TextButton(
                                                    onPressed: () {
                                                      print('cancel');
                                                    },
                                                    child: Text('Cancel')),
                                                TextButton(
                                                  onPressed: () {
                                                    print('Yes');
                                                  },
                                                  child: Text('Yes'),
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    child: Text('Remove From Playlists')),
                                value: 1,
                              ),
                              // PopupMenuItem(
                              //   child: TextButton(
                              //       onPressed: () {},
                              //       child: Text('Add to Favorites')),
                              //   value: 2,
                              // ),
                            ]),
                // subtitle: Text('data'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
