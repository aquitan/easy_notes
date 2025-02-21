import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/db/note_database.dart';
import 'package:easy_notes/repository/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    super.dispose();
  }

  void createNote() {
    final note =
        NoteModel(title: titleController.text, text: textController.text);

    context.read<NoteDatabase>().createNote(note);

    titleController.clear();
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать заметку'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(spacing: 16.0, children: [
              TextField(
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                controller: titleController,
                decoration: InputDecoration(
                    label: Text(
                  'Введи заголовок',
                  style: TextStyle(color: theme.colorScheme.secondary),
                )),
              ),
              TextField(
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                controller: textController,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    label: Text(
                      'Введи Текст',
                      style: TextStyle(color: theme.colorScheme.secondary),
                    )),
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: createNote, icon: Icon(Icons.check))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}