import 'package:flutter/material.dart';

class NewPlayList extends StatelessWidget {
  const NewPlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Give Playlist Name",
                  ),
              const    SizedBox(
                    height: 10,
                  ),
              const    TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: ''),
                  ),
             const     SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {},
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ))
                ])));
  }
}
