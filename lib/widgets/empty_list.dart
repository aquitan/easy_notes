import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/router/router.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child:  Column(
        spacing: 20.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('У тебя еще нет заметок', style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.tertiary
          ),),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty<Color?>.fromMap(<WidgetStatesConstraint, Color?>{
                WidgetState.error: Colors.red,
                WidgetState.hovered & WidgetState.focused: Colors.blueAccent,
                WidgetState.focused: Colors.blue,
                ~WidgetState.disabled: theme.colorScheme.primary,
              })
            ),
            onPressed: (){
              AutoRouter.of(context).push(CreateRoute());
            },
          child: const Text('Добавить', style: TextStyle(color: Colors.white, fontSize: 20.0),))
        ],
      ),
    );
  }
}