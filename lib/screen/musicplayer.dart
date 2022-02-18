import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musion/controller/musiccontroller.dart';
import 'package:musion/controller/playing.dart';
import 'package:musion/main.dart';

import 'package:musion/screen/allsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

// import 'package:musion/screen/home.dart';
import 'allsongs.dart';

class MusicPlayer extends StatefulWidget {
  final String title;
  final String artist;
  final int index;
  final List<Audio> audio;

  MusicPlayer({
    Key? key,
    required this.title,
    required this.artist,
    required this.index,
    required this.audio,
  }) : super(key: key);
  // bool isPlaying = false;

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  Duration _duration = Duration();
  Duration _position = Duration();

  Audio? myAudio;
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
            title: Text(
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
          padding: const EdgeInsets.all(10.0),
          child: player.builderCurrent(builder: (context, Playing? playing) {
            myAudio = find(widget.audio, playing!.audio.assetAudioPath);

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(10)),
                  Center(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        width: 300,
                        height: 300,
                        child: Image.network(myAudio!.metas.image!.path)),
                  )),
                  SizedBox(
                    height: 80,
                  ),
                  Builder(builder: (
                    context,
                  ) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          myAudio!.metas.title!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Wrap(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.library_add_outlined))
                          ],
                        ),
                      ],
                    );
                  }),
                  Row(
                    children: [Text(myAudio!.metas.artist!)],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: <Widget>[
                      player.builderRealtimePlayingInfos(
                        builder: (context, RealtimePlayingInfos? currentinfo) {
                          if (currentinfo == null) {
                            return Text('data');
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

  // Widget slider() {
  //   return Slider(
  //       activeColor: Colors.black,
  //       inactiveColor: Colors.grey,
  //       min: 0.0,
  //       max: _duration.inSeconds.toDouble(),
  //       value: _position.inSeconds.toDouble(),
  //       onChanged: (double value) {
  //         setState(() {
  //           changeToSecond(value.toInt());
  //           value = value;
  //         });
  //       });
  // }

  // void changeToSecond(int second) {
  //   Duration newDuration = Duration(seconds: second);
  //   player.seek(newDuration);
  // }
}
