import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/db/note_database.dart';
import 'package:easy_notes/repository/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();


  @override
  void dispose(){
    titleController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readNotes();
    });

  }

  // create note
  void createNote() {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Создай заметку'),
            content: SizedBox(
              height: 150,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      label: Text('Название'),
                    ),
                  ),
                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      label: Text('Текст'),
                    ),
                  )
                ]
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Отмена')),
              TextButton(onPressed: () {

                final note = NoteModel(title: titleController.text, text: textController.text);

                context.read<NoteDatabase>().createNote(note);

                titleController.clear();
                textController.clear();
                Navigator.pop(context);
              }, child: Text('Создать'))
            ],
          );
      }
    );
  }

  // read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update notes

  // delete notes

  @override
  Widget build(BuildContext context) {
    // note db watch
    final noteDb = context.watch<NoteDatabase>();

    // current notes
    List<NoteModel> currentNotes = noteDb.notes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заметки'),
      ),
      floatingActionButton: FilledButton(onPressed: createNote, child: Icon(Icons.add)),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(currentNotes[index].title),
            subtitle: Text(currentNotes[index].text),
          );
      }),
    );
  }
}