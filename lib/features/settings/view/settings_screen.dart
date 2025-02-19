import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/db/note_database.dart';
import 'package:easy_notes/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          spacing: 20.0,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Темная тема',
                  style: TextStyle(fontSize: 20.0),
                ),
                CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context).isDark,
                    onChanged: (value) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Очистить хранилище',
                  style: TextStyle(fontSize: 20.0),
                ),
                IconButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.red.shade500)),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(top: 60.0),
                            child: Container(
                                height: 200.0,
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    left: 16.0,
                                    right: 16.0,
                                    bottom: 16.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surface,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24.0),
                                  ),
                                ),
                                child: Column(
                                  spacing: 30.0,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      'Вы уверены, что хотите удалить все заметки?',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        Colors.red.shade600)),
                                            onPressed: () {
                                              Provider.of<NoteDatabase>(context,
                                                      listen: false)
                                                  .clearDatabase();
                                              Navigator.of(context).pop();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Заметки удалены'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Ok'),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Text(
                                              'Уверен',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            )),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        Colors.green.shade600)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ой, нет',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0))),
                                      ],
                                    )
                                  ],
                                )),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Очистить кэш',
                  style: TextStyle(fontSize: 20.0),
                ),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.red.shade500),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.cached,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}