import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/db/note_database.dart';
import 'package:easy_notes/repository/models/note_model.dart';
import 'package:easy_notes/router/router.dart';
import 'package:easy_notes/widgets/note_preview.dart';
import 'package:easy_notes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
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

    return Scaffold(
        appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Привет, Aquitan',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Сегодня ${DateFormat.MMMMd('ru_RU').format(DateTime.now())}',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: theme.colorScheme.tertiary),
                ),
              ],
            ),
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(ProfileRoute());
                  },
                  child: CircleAvatar(
                    backgroundColor: theme.colorScheme.secondary,
                    child: Text("AA"),
                  ),
                ),
              ),
            ]),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Это твои заметки',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 0, bottom: 50.0),
                    child: currentNotes.isEmpty
                        ? EmptyList()
                        : ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10.0,
                                ),
                            itemCount: currentNotes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                key: Key(currentNotes[index].id.toString()),
                                onDismissed: (direction) {
                                  Provider.of<NoteDatabase>(context,
                                          listen: false)
                                      .deleteNote(currentNotes[index].id);
                                  Fluttertoast.showToast(
                                      msg: "Заметка удалена",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM_RIGHT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                },
                                background: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red.shade500,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                ),
                                child: NotePreview(note: currentNotes[index]),
                              );
                            }),
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
}
