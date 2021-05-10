import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorials/common/constants.dart';
import 'package:tutorials/google_sign_in_firebase/home_google_sign_in.dart';
import 'package:tutorials/notes/providers/note_provider.dart';
import 'package:tutorials/notes/routes/edit_note/edit_note_page.dart';
import 'package:tutorials/notes/routes/home/home_page.dart';
import 'package:tutorials/notes/services/sqlite.dart';

import 'notes/routes/search_note/search_note.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SQLite.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoteProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (_) => _Home(),
        Routes.notesHome: (_) => NotesHomePage(),
        Routes.editNote: (_) => EditNotePage(),
        Routes.searchNote: (_) => SearchNotePage(),
      },
    );
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorials'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Google Sign In'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeGoogleSignIn(),
                  ));
            },
          ),
          ListTile(
            title: Text('Notes App'),
            onTap: () {
              Navigator.pushNamed(context, Routes.notesHome);
            },
          ),
        ],
      ),
    );
  }
}
