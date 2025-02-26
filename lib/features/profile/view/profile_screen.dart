import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
      title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            spacing: 20.0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundColor: theme.colorScheme.secondary,
                child: Text("AA"),
              ),
              Text(
                'Aquitan Aquitan',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: theme.colorScheme.tertiary, width: 1.0)),
                  ),
                  child: const Row(
                    spacing: 20.0,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.info_outline), Text('О нас')],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: theme.colorScheme.tertiary, width: 1.0)),
                  ),
                  child: const Row(
                    spacing: 20.0,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.question_mark), Text('Вопрос-ответ')],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: theme.colorScheme.tertiary, width: 1.0)),
                  ),
                  child: const Row(
                    spacing: 20.0,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.thumb_up), Text('Поддержи нас')],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Row(
                  spacing: 20.0,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    Text(
                      'Выйти',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}