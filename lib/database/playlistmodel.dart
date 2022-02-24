
import 'package:hive/hive.dart';
 part 'playlistmodel.g.dart';

@ HiveType(typeId:1)
class PlaylistModels extends HiveObject {
  @ HiveField(0)
  late dynamic title;
  PlaylistModels({required this.title});
  
}
