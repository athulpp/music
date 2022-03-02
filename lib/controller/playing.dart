
import 'package:flutter/material.dart';


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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.grey),
      width: 400,
      height: 50,
      // color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: onPrevious,
            icon:const Icon(
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
            icon: const Icon(Icons.skip_next),
            color: Colors.black,
            iconSize: 32,
          ),
        ],
      ),
    );
  }
}
