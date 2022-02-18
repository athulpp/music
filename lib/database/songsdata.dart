import 'package:hive/hive.dart';
part 'songsdata.g.dart';

@HiveType(typeId: 0)
class DataSongModel extends HiveObject {
  @HiveField(0)
  late List? songs;
}
