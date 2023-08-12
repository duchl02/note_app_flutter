import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/model/note.dart';

import 'local_storage.dart';

class NoteLocalStorageHelper implements LocalStorage<Note> {
  NoteLocalStorageHelper._internal();
  static final NoteLocalStorageHelper _shared =
      NoteLocalStorageHelper._internal();

  factory NoteLocalStorageHelper() {
    return _shared;
  }

  late Box<Note> _noteBox;

  static const String _defaultBoxName = 'noteBox';

  @override
  Future<void> initLocalStorageHelper() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
    _shared._noteBox = await Hive.openBox(_defaultBoxName);
  }

  @override
  Future<void> closeBox() async {
    _shared._noteBox.close();
  }

  @override
  Future<void> saveBox(Note note) async {
    await _shared._noteBox.add(note);
  }

  @override
  Future<void> updateItem(Note note) async {
    final index =
        _shared._noteBox.values.toList().indexWhere((p) => p.id == note.id);
    if (index != -1) {
      await _shared._noteBox.putAt(index, note);
    }
  }

  @override
  List<Note> getAllItems() {
    return _shared._noteBox.values.toList();
  }

  @override
  Future<void> updateListNote(List<Note> items) async {
    await _shared._noteBox.clear();
    await _shared._noteBox.addAll(items);
  }

  @override
  List<Note> searchItems(String query) {
    final notes = _shared._noteBox.values
        .where((note) =>
            (note.body?.toLowerCase() ?? '').contains(query.toLowerCase()))
        .toList();
    return notes;
  }

  @override
  Box<Note> getBox() {
    return _shared._noteBox;
  }

  @override
  Future<void> deleteItem(String id) async {
    final index =
        _shared._noteBox.values.toList().indexWhere((note) => note.id == id);

    if (index != -1) {
      await _shared._noteBox.deleteAt(index);
    } else {
      throw Exception('Person not found.');
    }
  }
}
