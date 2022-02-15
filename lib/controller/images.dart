import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customListTile({String? title, String? artists, String? cover, OnTap}) {
  return Container(
    padding: EdgeInsets.all(8),
    child: Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(image: NetworkImage(cover!))),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Text(
              title!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              artists!,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )
          ],
        )
      ],
    ),
  );
}
