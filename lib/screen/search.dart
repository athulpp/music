import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musion/controller/opensMusic.dart';
import 'package:musion/database/databasefunctions/datafunction.dart';

import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key, required this.audios}) : super(key: key);

  final List<Audio> audios;

  final controller = Get.put(DataFunction());

  AssetsAudioPlayer get assetsAudioPlayer => AssetsAudioPlayer.withId('music');
  String searchText = "";
  List<Audio> dummy = [];

  TextEditingController searchcontroll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (value) {
                  Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      searchText = value;
                      controller.update(["results"]);
                    },
                  );
                },
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'Search'),
              ),
            ),
            Expanded(
              child: GetBuilder<DataFunction>(
                id: "results",
                builder: (controller) {
                  List<Audio> result = searchText == ''
                      ? dummy.toList()
                      : audios
                          .where(
                            (element) =>
                                element.metas.title!.toLowerCase().contains(
                                      searchText.toLowerCase(),
                                    ),
                          )
                          .toList();
                  return ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          OpenPlayer().openPlayer(index, result);
                        },
                        child: ListTile(
                          leading: QueryArtworkWidget(
                            nullArtworkWidget: Image.asset(
                                'assests/images/apple-music-logo.png'),
                            id: int.parse(result[index].metas.id.toString()),
                            type: ArtworkType.AUDIO,
                          ),
                          title: Text(result[index].metas.title.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1),
                          subtitle: Text(result[index].metas.artist.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText2),
                          trailing: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
