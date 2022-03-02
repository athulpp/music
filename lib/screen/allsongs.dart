import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musion/controller/opensMusic.dart';

import 'package:musion/screen/musicplayer.dart';
import 'package:musion/widgets/popupmenu.dart';

import 'package:on_audio_query/on_audio_query.dart';

class AllSongs extends StatelessWidget {
  final List<Audio> audios;
  AllSongs({Key? key, required this.audios}) : super(key: key);

  AssetsAudioPlayer get player => AssetsAudioPlayer.withId('music');

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  List<Audio> audio = [];
  Audio? myAudio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title:const Text(
            'All Songs',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: audios.length,
                    itemBuilder: (BuildContext context, int index) {
                      var image = int.parse(audios[index].metas.id.toString());
                      return ListTile(
                          onTap: () {
                            OpenPlayer().openPlayer(index, audios);
                            Get.to(() => MusicPlayer(
                                  audio: audios,
                                ));
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              child: QueryArtworkWidget(
                                id: image,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: Image.asset(
                                    'assests/images/apple-music-logo.png'),
                              ),
                              width: 50,
                              height: 50,
                            ),
                          ),
                          title: Text(
                            audios[index].metas.title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            audios[index].metas.artist!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Popupmenu(audios: audios, index: index));
                    }),
              ),
            ),
            RecentlyPlayed()
          ],
        ));
  }

  PlayerBuilder  RecentlyPlayed() {
    return player.builderCurrent(
      builder: (context, Playing? playing) {
        myAudio = find(audios, playing!.audio.assetAudioPath);
        var image = int.parse(myAudio!.metas.id!);
        return Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => MusicPlayer(
                        audio: audios,
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: ListTile(
                      leading: QueryArtworkWidget(
                        id: image,
                        nullArtworkWidget:
                            Image.asset('assests/images/apple-music-logo.png'),
                        // id: image,
                        type: ArtworkType.AUDIO,
                      ),
                      title: Text(
                        myAudio!.metas.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        myAudio!.metas.artist!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: PlayerBuilder.isPlaying(
                        player: player,
                        builder: (context, isPlaying) {
                          return IconButton(
                            onPressed: () async {
                              await player.playOrPause();
                            },
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.black,
                              size: 32,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
