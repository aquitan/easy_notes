import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/db/note_database.dart';
import 'package:easy_notes/repository/models/note_model.dart';
import 'package:easy_notes/router/router.dart';
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
    final theme = Theme.of(context);

    // current notes
    List<NoteModel> currentNotes = noteDb.notes;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
                pinned: true,
                snap: true,
                floating: true,
                surfaceTintColor: Colors.transparent,
                title: const Text(
                  'Привет, Aquitan',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                ),
                centerTitle: false,
                actions: [
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context).push(ProfileRoute());
                    },
                    child: CircleAvatar(
                      backgroundColor: theme.colorScheme.secondary,
                      child: Text("AA"),
                    ),
                  ),
                ]),
            SliverToBoxAdapter(
                child: Text(
              'Категории',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            )),
            SliverList.separated(
                itemCount: currentNotes.length,
                separatorBuilder: (_, index) => SizedBox(
                      height: 10.0,
                    ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: theme.colorScheme.secondary,
                    ),
                    child: SizedBox(
                        child: Row(
                      children: [
                        Expanded(
                            child: Column(
                                spacing: 10.0,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(
                                currentNotes[index].title,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(softWrap: true, currentNotes[index].text),
                            ])),
                      ],
                    )),
                  );
                })
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            child: FilledButton(
                onPressed: createNote,
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16.0,
                    children: [
                      Text(
                        'Быстрая заметка',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      )
                    ])),
          ),
        )
      ]),
    );
  }
}