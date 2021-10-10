import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorials/common/routes.dart';
import 'package:tutorials/notes/providers/note_provider.dart';
import 'package:tutorials/notes/services/sqlite.dart';

/// Dart's starting point.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SQLite.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

/// It is the root of the project.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tutorials',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateInitialRoutes: Routes.generateInitialRoutes,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
