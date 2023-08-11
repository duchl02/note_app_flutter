import 'package:hive_flutter/hive_flutter.dart';

import 'model/note.dart';

class AppInitializer {
  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Note>(NoteAdapter());
  }
}
