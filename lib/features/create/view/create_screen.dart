import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/db/note_database.dart';
import 'package:easy_notes/repository/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  Map<String, dynamic> dropdownValue = {
    'value': 'Общие',
    'color': Colors.amber
  };
  List<Map<String, dynamic>> dropdownItems = [
    {'value': 'Общие', 'color': Colors.amber},
    {'value': 'Работа', 'color': Colors.blue},
    {'value': 'Учеба', 'color': Colors.red},
    {'value': 'Другое', 'color': Colors.grey},
  ];

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    super.dispose();
  }

  void createNote() {
    final note =
        NoteModel(
        checked: false,
        title: titleController.text,
        text: textController.text,
        category: dropdownValue['value'].toString().toLowerCase());

    context.read<NoteDatabase>().createNote(note);
    Fluttertoast.showToast(
        msg: "Заметка создана",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
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
            child: Column(spacing: 15.0, children: [
              Row(
                children: [
                  DropdownButton<Map<String, dynamic>>(
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          dropdownValue = value;
                        });
                      }
                    },
                    value: dropdownItems.firstWhere(
                      (item) => item['value'] == dropdownValue['value'],
                      orElse: () => dropdownItems[
                          0], // Если не найдено, берём первый элемент
                    ),
                    items: dropdownItems.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: item['color'],
                              ),
                              margin: const EdgeInsets.only(right: 8),
                              width: 5.0,
                              height: 5.0,
                            ),
                            Text(item['value'])
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              TextField(
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                controller: titleController,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade500, width: 2.0),
                    ),
                    isDense: true,
                    labelStyle: TextStyle(
                      fontSize: 24.0,
                    ),
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
                    border: InputBorder.none,
                    isDense: true,
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      fontSize: 24.0,
                    ),
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
                    IconButton(
                        onPressed: createNote,
                        icon: Icon(
                          Icons.check,
                          color: theme.colorScheme.primary,
                          size: 30.0,
                        )),
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