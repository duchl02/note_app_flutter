import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/style/color_default.dart';
import 'package:uuid/uuid.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    this.note,
    super.key,
  });
  final Note? note;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note?.title ?? '';
    _noteController.text = widget.note?.body ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghi chú'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(
              context,
              Note(
                id: widget.note?.id ?? const Uuid().v1(),
                title: _titleController.text,
                body: _noteController.text,
                createAt: widget.note?.createAt ?? DateTime.now(),
                updateAt: DateTime.now(),
              )),
        ),
      ),
      body: Container(
        color: ExColorSysToken.backgroundColor,
        padding: const EdgeInsets.all(10.0),
        child: Hero(
          tag: widget.note?.id ?? '',
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                child: TextFormField(
                  style: theme.textTheme.titleLarge,
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintStyle: theme.textTheme.titleLarge?.copyWith(
                        color: ExColorSysToken.textColor.withOpacity(0.5)),
                    border: InputBorder.none,
                    hintText: 'Tiêu đề',
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: TextFormField(
                    style: theme.textTheme.bodyMedium,
                    controller: _noteController,
                    decoration: InputDecoration(
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: ExColorSysToken.textColor.withOpacity(0.5)),
                      border: InputBorder.none,
                      hintText: 'Ghi chú',
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    maxLines: null,
                  ),
                ),
              ),
              Text(
                'Cập nhật lần cuối : ${widget.note?.updateAt.toString()}',
                style: theme.textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
