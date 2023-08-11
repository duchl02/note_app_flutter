import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:note_app/style/color_default.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../routers/router_name.dart';

class ReorderableNote extends StatefulWidget {
  const ReorderableNote({Key? key}) : super(key: key);

  @override
  State<ReorderableNote> createState() => _ReorderableNoteState();
}

class _ReorderableNoteState extends State<ReorderableNote> {
  
  final data = List<int>.generate(5, (index) => index);
  double scrollSpeedVariable = 5;

  void add() {
    setState(() {
      data.insert(0, data.length);
    });
  }

  Widget _buildGrid(BuildContext context) {
    final theme = Theme.of(context);

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
          onTap: () {
            Navigator.of(context)
                .pushNamed(RouteNames.addNote)
                .then((value) => add());
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: const Color.fromRGBO(95, 99, 103, 1)),
            ),
            child: const Center(child: Icon(Icons.add)),
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
        setState(() {
          final element = data.removeAt(oldIndex);
          data.insert(newIndex, element);
        });
      },
      children: data
          .map((index) => GestureDetector(
                key: ValueKey(index),
                onTap: () => Navigator.pushNamed(context, RouteNames.addNote)
                    .then((value) => setState(() {})),
                child: Hero(
                  tag: index,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(32, 33, 36, 1),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      border: Border.all(
                          color: const Color.fromRGBO(95, 99, 103, 1)),
                    ),
                    child: Text(
                      index.toString(),
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
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
