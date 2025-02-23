import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/db/note_database.dart';
import 'package:easy_notes/repository/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

@RoutePage()
class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key, required this.note});

  final NoteModel note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void updateNote() {
    final note = NoteModel(
        checked: false,
        title: _titleController.text,
        text: _textController.text,
        category: dropdownValue['value'].toString().toLowerCase());
    Fluttertoast.showToast(
        msg: "Заметка сохранена",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0);
    context.read<NoteDatabase>().updateNote(widget.note.id, note);
  }

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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    setState(() {
      _titleController.text = widget.note.title;
      _textController.text = widget.note.text;
    });
    return Scaffold(
      appBar: AppBar(
          title: Text('${widget.note.title} ${widget.note.id}'),
        ),
        body: Stack(children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Column(children: [
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
                  orElse: () =>
                      dropdownItems[0], // Если не найдено, берём первый элемент
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
              ),
              TextField(
                controller: _titleController,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade500, width: 2.0),
                  ),
                  isDense: true,
                  labelStyle: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              TextField(
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                controller: _textController,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
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
                        onPressed: updateNote,
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
        ])
    );
  }
}