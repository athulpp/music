import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musion/screen/allsongs.dart';

List<Audio> audios11 = [
  Audio("assests/audios/music.mp3",
      metas: Metas(
          title: 'Tera Ho Raha Hoon',
          artist: 'Nikhita Gandhi',
          image: const MetasImage.network(
              'https://lyricsworldyou.com/wp-content/uploads/2022/02/TERA-HO-RAHA-HOON-LYRICS-Sourav-Joshi.webp'))),
  Audio("assests/audios/Sorry Alan Walker 128 Kbps.mp3",
      metas: Metas(
          title: 'Sorry Alan Walker',
          artist: 'Alan Walker',
          image: const MetasImage.network(
              'https://i.ytimg.com/vi/8RGxF9JltAQ/maxresdefault.jpg'))),
  Audio("assests/audios/Your Power Billie Eilish 128 Kbps.mp3",
      metas: Metas(
          title: 'Your Power',
          artist: 'Billie Eilish',
          image: const MetasImage.network(
              'https://images.genius.com/b826bffa6a542a466c2143f4702b9f25.1000x1000x1.png'))),
  Audio("assests/audios/Electric Katy Perry 128 Kbps.mp3",
      metas: Metas(
          id: '4',
          title: 'Electric',
          artist: 'Katy Perry',
          image: const MetasImage.network(
              'https://images.ctfassets.net/ycci6h8ksgtu/6uokVfiiaR9fKj1SgKxcNj/4ec49f6c7e62ea6d6a757ff2558974e2/katy_album')))
];
