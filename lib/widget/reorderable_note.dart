import 'package:dartx/dartx.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/storage/note_local_storage_helper.dart';
import 'package:note_app/style/color_default.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../routers/router_name.dart';

class ReorderableNote extends StatefulWidget {
  const ReorderableNote({Key? key}) : super(key: key);

  @override
  State<ReorderableNote> createState() => _ReorderableNoteState();
}

class _ReorderableNoteState extends State<ReorderableNote> {
  double scrollSpeedVariable = 5;

  final Box<Note> noteBox = NoteLocalStorageHelper().getBox();

  void add(Note note) {
    if (note.body.isNotNullOrEmpty || note.title.isNotNullOrEmpty) {
      final notes = noteBox.values.toList();
      notes.insert(0, note);
      NoteLocalStorageHelper().updateListNote(notes);
    }
  }

  void updateNote(Note note) {
    NoteLocalStorageHelper().updateItem(note);
  }

  Future<void> deleteNote(String id) async {
    const snackBar = SnackBar(
      content: Text('Xoá thành công'),
      duration: Duration(seconds: 2),
    );
    const snackBarError = SnackBar(
      content: Text('Đã có lỗi xảy ra'),
      duration: Duration(seconds: 2),
    );
    try {
      await NoteLocalStorageHelper().deleteItem(id);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarError);
    }
  }

  @override
  void dispose() {
    NoteLocalStorageHelper().closeBox();
    super.dispose();
  }

  Widget _buildGrid(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
        valueListenable: noteBox.listenable(),
        builder: (context, value, child) {
          final notes = noteBox.values.toList();

          return ReorderableGridView.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            childAspectRatio: 0.6,
            dragWidgetBuilderV2: DragWidgetBuilderV2(
                builder: (int index, Widget child, ImageProvider? screenshot) {
              return child;
            }),
            header: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, RouteNames.addNote)
                    .then((value) {
                  if (value != null) {
                    add(value as Note);
                  }
                }),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    border:
                        Border.all(color: const Color.fromRGBO(95, 99, 103, 1)),
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
                ),
              )
            ],
            dragStartBehavior: DragStartBehavior.down,
            scrollSpeedController:
                (int timeInMilliSecond, double overSize, double itemSize) {
              if (timeInMilliSecond > 1500) {
                scrollSpeedVariable = 15;
              } else {
                scrollSpeedVariable = 5;
              }
              return scrollSpeedVariable;
            },
            onReorder: (oldIndex, newIndex) {
              final element = notes.removeAt(oldIndex);
              notes.insert(newIndex, element);
              NoteLocalStorageHelper().updateListNote(notes.toList());
            },
            children: notes
                .map((note) => GestureDetector(
                      key: ValueKey(note),
                      onTap: () => Navigator.pushNamed(
                              context, RouteNames.addNote,
                              arguments: note)
                          .then((value) {
                        if (value != null) {
                          updateNote(value as Note);
                        }
                      }),
                      onDoubleTap: () => deleteNote(note.id ?? ''),
                      child: Hero(
                        tag: note.id ?? '',
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(32, 33, 36, 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                color: const Color.fromRGBO(95, 99, 103, 1)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: note.title.isNotNullOrEmpty,
                                child: Text(
                                  note.title.toString(),
                                  style: theme.textTheme.titleMedium,
                                  maxLines: 3,
                                ),
                              ),
                              Text(
                                note.body.toString(),
                                style: theme.textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ExColorSysToken.backgroundColor,
        padding: const EdgeInsets.all(10),
        child: _buildGrid(context));
  }

  Widget buildItem(int index) {
    return Card(
      key: ValueKey(index),
      child: Text(index.toString()),
    );
  }
}
