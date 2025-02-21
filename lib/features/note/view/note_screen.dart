import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/repository/models/note_model.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key, required this.id});

  final int id;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  late NoteModel note;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заметка'),
      ),
    );
  }
}