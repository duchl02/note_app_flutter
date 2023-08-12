import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? body;
  @HiveField(3)
  DateTime? updateAt;
  @HiveField(4)
  late DateTime? createAt;

  Note({this.id, this.body, this.createAt, this.title, this.updateAt});
}