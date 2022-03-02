import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musion/controller/addsongplaylist.dart';
import 'package:musion/controller/favoritebutton.dart';

import 'package:musion/controller/playing.dart';
import 'package:musion/database/databasefunctions/datafunction.dart';

import 'package:on_audio_query/on_audio_query.dart';

class MusicPlayer extends StatelessWidget {
  final List<Audio> audio;

  MusicPlayer({
    Key? key,
    required this.audio,
  }) : super(key: key);

  bool usertouch = true;
  bool isPlaying = false;

  AssetsAudioPlayer get player => AssetsAudioPlayer.withId('music');
  Audio? myAudio;
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'NOW PLAYING',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  Get.back();
                })),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: player.builderCurrent(builder: (context, Playing playing) {
            myAudio = find(audio, playing.audio.assetAudioPath);
            var image = int.parse(playing.audio.audio.metas.id!);
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  Center(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: QueryArtworkWidget(
                        id: image,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget:
                            Image.asset('assests/images/apple-music-logo.png'),
                      ),
                    ),
                  )),
                  const SizedBox(
                    height: 30,
                  ),
                  Builder(builder: (
                    context,
                  ) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              myAudio!.metas.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            )),
                        Row(
                          children: [
                            GetBuilder<DataFunction>(
                                id: 'fav',
                                builder: (controller) {
                                  return FavoriteButton(
                                    myAudio: myAudio!,
                                  );
                                }),
                            GetBuilder<DataFunction>(
                                id: 'addplaylist',
                                builder: (controller) {
                                  return AddSongToPlaylist(audio: myAudio!);
                                })
                          ],
                        ),
                      ],
                    );
                  }),
                  Row(
                    children: [
                      SizedBox(width: 200, child: Text(myAudio!.metas.artist!))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      player.builderRealtimePlayingInfos(
                        builder: (context, RealtimePlayingInfos? currentinfo) {
                          if (currentinfo == null) {
                            return const Text('data');
                          }
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 20.0,
                                    bottom: 20.0),
                                child: ProgressBar(
                                  thumbRadius: 1,
                                  thumbColor: Colors.grey,
                                  progressBarColor: Colors.grey,
                                  progress: currentinfo.currentPosition,
                                  total: currentinfo.duration,
                                  onSeek: (to) {
                                    player.seek(to);
                                  },
                                ),
                              ),
                              PlayerBuilder.isPlaying(
                                player: player,
                                builder: (context, isPlaying) {
                                  return PlayingControls(
                                    isPlaying: isPlaying,
                                    onPlay: () async {
                                      await player.playOrPause();
                                    },
                                    onNext: () async {
                                      await player.next();
                                    },
                                    onPrevious: () async {
                                      await player.previous();
                                    },
                                  );
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
