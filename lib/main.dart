import 'package:easy_notes/db/note_database.dart';
import 'package:easy_notes/firebase_options.dart';
import 'package:easy_notes/notes_app.dart';
import 'package:easy_notes/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoteDatabase()),
      ChangeNotifierProvider(create: (_) => ThemeProvider())
    ],
    child: NotesApp(),
  )
  );
}

