import 'package:flutter/material.dart';
import 'package:note_app/init_app.dart';
import 'package:note_app/routers/app_routes.dart';
import 'package:note_app/screen/list_note_screen.dart';
import 'package:note_app/style/text_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppInitializer().initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: appTextTheme,
      ),
      home: const ListNoteScreen(),
      onGenerateRoute: generateRoutes,
    );
  }
}
