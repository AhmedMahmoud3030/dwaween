import 'package:hive/hive.dart';
part 'favourite.g.dart';

@HiveType(typeId: 1)
class Favourite {
  @HiveField(0)
  final String Dname;
  @HiveField(1)
  final String Kname;
  
  Favourite({
    required this.Dname,
    required this.Kname,
  });
}
