import 'package:flutter/material.dart';
import 'package:note_app/style/color_default.dart';

class AddNoteScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: ExColorSysToken.backgroundColor,
        padding: const EdgeInsets.all(10.0),
        child: Hero(
          tag: 1,
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintStyle: theme.textTheme.titleLarge,
                    border: InputBorder.none, // Tắt border
                    hintText: 'Tiêu đề',
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: TextFormField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    hintStyle: theme.textTheme.bodyMedium,
                    border: InputBorder.none, // Tắt border
                    hintText: 'Ghi chú',
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
