import 'package:flutter/material.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(child: Image.asset('assests/images/apple-music-logo.png')),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) => ListTile(
                  onTap: () => {index, print(index)},
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                  title: Text('Playlists $index'),
                  trailing:PopupMenuButton(
                      color: Colors.white,
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Alert'),
                                            content: Text('Do you want Remove from Playlist'),
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
                                  child: Text('Remove From Favorites')),
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
      ),
      // body: Container(
      //   child: Column(
      //     children: [
      //       Center(child: Image.asset('assests/images/fav.png')),
      //       Flexible(
      //         child: SingleChildScrollView(
      //           child: ListView.builder(
      //             shrinkWrap: true,
      //             itemCount: 10,
      //             itemBuilder: (context, index) => ListTile(
      //               onTap: () => {index, print(index)},
      //               leading: CircleAvatar(
      //                 backgroundColor: Colors.green,
      //               ),
      //               title: Text('Playlists $index'),
      //               // subtitle: Text('data'),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
