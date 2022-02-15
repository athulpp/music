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
  bool isPlaying = false;
  // final _value = 0;
  // AssetsAudioPlayer player => AssetsAudioPlayer.withId('music');

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  List datas = [
    {'title': 'Din Din bhonsala', 'artists': 'Florent champingny'}
  ];
  // double _value = 0;
  // AllSongs hi = AllSongs();
  // OpenAssetAudio sleek = OpenAssetAudio();
  Audio? myAudio;

  static var title;
  Duration _duration = Duration();
  Duration _position = Duration();
  // bool isPlaying = false;
  // @override
  // void initState() {
  //   // TODO: implement initState

  //   this.widget.onDurationChanged.listen((d) {
  //     setState(() {
  //       _duration = d;
  //     });
  //     this.widget.player.onAudioPositionChanged.listen((p) {
  //       setState(() {
  //         _position = p;
  //       });
  //     });
  //   });
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   playerCtrl.isAudioPlayerPlaying.listen((value) {
  //     if (mounted) {
  //       setState(() {
  //         playerCtrl.isPlaying.value = value;
  //       });
  //       print("Status set to: ${player.isPlaying.value}");
  //     }
  //   });
  // }
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    // widget.audio;
    widget.index;
    widget.title;
    widget.artist;
    // );
    return Scaffold(
        appBar: AppBar(
            // leading: IconButton(
            //     onPressed: () => Get.toNamed('/all'), icon: Icon(Icons.home)),
            title: Text(
              'NOW PLAYING',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            //         leading: IconButton(onPressed: (){
            //   Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => HomeScreen()));
            // }, icon:Icon(Icons.arrow_back)),
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
                      child: Image.asset(
                    'assests/images/apple-music-logo.png',
                    scale: 0.1,
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
                        // Text(
                        //   title,
                        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        // ),

                        Text(myAudio!.metas.title!),

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
                  // Row(
                  //   children: [],
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 300,
                    child: Row(
                      children: [
                        // sleek.seekBarWidget(context),
                        // Expanded(
                        //   child: Slider(
                        //     min: 0.0,
                        //     max: 200.0,
                        //     value: _value,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         _value = value;
                        //       });
                        //     },
                        //   ),
                        // )
                      ],
                      // children: [
                      //   Text(
                      //     _position.toString().split(".")[0],
                      //   ),
                      //   Text(_duration.toString().split(".")[0])
                      // ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Padding(
                  //     padding: const EdgeInsets.all(25.0),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width,
                  //       // color: Colors.grey,
                  //       decoration: BoxDecoration(
                  //           border: Border.all(
                  //             color: Colors.grey,
                  //           ),
                  //           borderRadius: BorderRadius.all(Radius.circular(20))),
                  //       height: 50,
                  //       child: Column(children: <Widget>[
                  //         player.builderRealtimePlayingInfos(builder:
                  //             (context, RealtimePlayingInfos? currentinfo) {
                  //           return Wrap(
                  //             alignment: WrapAlignment.spaceBetween,
                  //             children: [

                  //               // SizedBox(
                  //               //   width: 20,
                  //               // ),
                  //               // IconButton(
                  //               //     onPressed: () {
                  //               //       ;
                  //               //     },
                  //               //     icon: Icon(Icons.repeat)),
                  //               IconButton(
                  //                   onPressed: () {
                  //                     playPrevious();
                  //                   },
                  //                   icon: Icon(Icons.skip_previous)),
                  //               // IconButton(
                  //               //   onPressed: () {
                  //               //     playPauseAudio();
                  //               //   },
                  //               //   icon: (player.isPlaying.value)
                  //               //       ? const Icon(
                  //               //           Icons.play_arrow,
                  //               //         )
                  //               //       : const Icon(
                  //               //           Icons.pause,
                  //               //         ),
                  //               // ),
                  //               //
                  //               Container(
                  //                 height: 37,
                  //                 width: 37,
                  //                 margin: const EdgeInsets.only(top: 5),
                  //                 decoration: BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   border: Border.all(
                  //                     width: 1,
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),
                  //                 child: player.builderIsPlaying(
                  //                   builder: (context, isPlaying) {
                  //                     return isPlaying
                  //                         ? Align(
                  //                             alignment: Alignment.center,
                  //                             child: IconButton(
                  //                               onPressed: () {
                  //                                 player.playOrPause();
                  //                               },
                  //                               icon: const Icon(
                  //                                 Icons.pause,
                  //                                 color: Colors.black,
                  //                                 size: 19,
                  //                               ),
                  //                             ),
                  //                           )
                  //                         : Align(
                  //                             alignment: Alignment.center,
                  //                             child: IconButton(
                  //                               onPressed: () {
                  //                                 player.playOrPause();
                  //                               },
                  //                               icon: const Icon(
                  //                                 Icons.play_arrow,
                  //                                 color: Colors.black,
                  //                                 size: 19,
                  //                               ),
                  //                             ),
                  //                           );
                  //                   },
                  //                 ),
                  //               ),

                  //               PlayerBuilder.isPlaying(
                  //                   player: player,
                  //                   builder: (context, isPlaying) {
                  //                     return IconButton(
                  //                         onPressed: () {
                  //                           playNext();
                  //                         },
                  //                         icon: Icon(
                  //                           Icons.skip_next,
                  //                         ));
                  //                   })
                  //             ],
                  //           );
                  //         }),
                  //       ]),
                  //     ))
                  Column(
                    children: <Widget>[
                      player.builderRealtimePlayingInfos(
                        builder: (context, RealtimePlayingInfos? currentinfo) {
                          if (currentinfo == null) {
                            return Text(
                              'Sorry',
                              style: TextStyle(color: Colors.black),
                            );
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
                                  bool nextDone = true;
                                  bool prevDone = true;
                                  return PlayingControls(
                                    isPlaying: isPlaying,
                                    isPlaylist: true,
                                    onPlay: () async {
                                      await player.playOrPause();
                                    },
                                    onNext: () async {
                                      if (nextDone) {
                                        nextDone = false;
                                        await player.next();
                                        nextDone = true;
                                      }
                                    },
                                    onPrevious: () async {
                                      if (prevDone) {
                                        prevDone = false;
                                        await player.previous();
                                        prevDone = true;
                                      }
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
