import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/repository/models/note_model.dart';
import 'package:easy_notes/router/router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum CategoryName {
  general,
  work,
  stydy,
  any
}


class NotePreview extends StatelessWidget {
  const NotePreview({super.key, required this.note});

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    Color categoryColorSelector(String? category) {
      switch (category?.toLowerCase()) {
        case 'общие':
          return Colors.amber;
        case 'работа':
          return Colors.blue;
        case 'учеба':
          return Colors.red;
        case 'другое':
          return Colors.grey;
        default:
          return Colors.grey;
      }
    }
    return GestureDetector(
            onTap: () {
              AutoRouter.of(context).push(
                  NoteRoute(note: note));
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
              color: categoryColorSelector(note.category),
              width: 4.0,
                  )
                ),
                  borderRadius:
                      BorderRadius.circular(25.0),
            color: theme.colorScheme.secondary),
              child: SizedBox(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Column(
                        spacing: 10.0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        note.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight:
                                      FontWeight.w600),
                      ),
                      Text(
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                          softWrap: true,
                          note.text),
                    ])),
              ],
            ),
            SizedBox(height: 10.0),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Icon(
                Icons.date_range_rounded,
                color: Colors.grey.shade200,
              ),
              Text(
                DateFormat.MMMEd('ru_RU').format(DateTime.now()),
                style: TextStyle(color: Colors.grey.shade200),
              )
            ])
          ],
        )),
            ),
          );
  }
}