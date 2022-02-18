import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musion/controller/musiccontroller.dart';
import 'package:musion/screen/allsongs.dart';

class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final Function()? onPrevious;
  final Function() onPlay;
  final Function()? onNext;

  PlayingControls({
    required this.isPlaying,
    this.onPrevious,
    required this.onPlay,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: onPrevious,
          icon: Icon(
            Icons.skip_previous,
            size: 32,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: onPlay,
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.black,
            size: 32,
          ),
        ),
        IconButton(
          onPressed: onNext,
          icon: Icon(Icons.skip_next),
          color: Colors.black,
          iconSize: 32,
        ),
      ],
    );
  }
}
