// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:musion/controller/musiccontroller.dart';
// import 'package:musion/screen/allsongs.dart';
// import 'package:musion/screen/home.dart';

// class Splash extends StatefulWidget {
//   const Splash({Key? key}) : super(key: key);

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   List<Audio>? audio;
//   @override
//   void initState() {
//     super.initState();
//     _navigatetohome();
//   }

//   _navigatetohome() async {
//     await Future.delayed(Duration(milliseconds: 1500), () {});
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => AllSongs(
//                   audios: audio!,
//                 )));
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           child: Image.asset('assests/images/Splash_screen.png', scale: 5),
//         ),
//       ),
//     );
//   }
// }
