import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/repository/models/note_model.dart';
import 'package:easy_notes/router/router.dart';
import 'package:easy_notes/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    Color categoryColorSelector(String category) {
      switch (category) {
        case 'general':
          return Colors.amber;
        case 'work':
          return Colors.blue;
        case 'study':
          return Colors.red;
        case 'any':
          return Colors.cyan;
        default:
          return Colors.amber;
      }
    }

    return GestureDetector(
            onTap: () {
              AutoRouter.of(context).push(
                  NoteRoute(id: note.id));
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: categoryColorSelector(note.category),
                    width: 6.0,
                  )
                ),
                  borderRadius:
                      BorderRadius.circular(5.0),
                  color: Provider.of<ThemeProvider>(context).isDark ? theme.colorScheme.secondary : categoryColorSelector(note.category).withAlpha(120)),
              child: SizedBox(
                  child: Row(
                children: [
                  Expanded(
                      child: Column(
                          spacing: 10.0,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                        Text(
                          note.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight:
                                  FontWeight.w500),
                        ),
                        Text(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight:
                                    FontWeight.w500),
                            softWrap: true,
                            note.text),
                      ])),
                ],
              )),
            ),
          );
  }
}