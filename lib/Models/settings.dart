import 'package:hive/hive.dart';
part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings {
  @HiveField(0)
  final String value;

  Settings({
    required this.value,
  });
}
