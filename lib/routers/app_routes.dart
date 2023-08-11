import 'package:flutter/material.dart';
import 'package:note_app/routers/router_name.dart';
import 'package:note_app/screen/add_note_screen.dart';
import 'package:note_app/screen/list_note_screen.dart';

final Map<String, WidgetBuilder> routes = {};

PageRoute? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.addNote:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => AddNoteScreen(),
      );
    case RouteNames.listNote:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ListNoteScreen(),
      );
    default:
      return null;
  }
}

class RoomModel {}
