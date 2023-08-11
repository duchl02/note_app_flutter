import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
@HiveType(typeId: 0)
class Note with _$Note {
  const factory Note({
    @HiveField(0) int? id,
    @HiveField(1) String? title,
    @HiveField(2) String? body,
    @HiveField(3) DateTime? updateAt,
    @HiveField(4) DateTime? createAt,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}
