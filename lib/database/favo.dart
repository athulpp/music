
import 'package:hive/hive.dart';
part 'favo.g.dart';
@ HiveType(typeId:4)
class Favoritesmosdel extends HiveObject{
   @HiveField(0)
  late dynamic fav;
 Favoritesmosdel ({required this.fav});
  
}
