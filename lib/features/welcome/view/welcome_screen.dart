import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/router/router.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 10.0,
          children: [
            SizedBox(
              height: h * 0.5,
              child: Lottie.asset('assets/welcome.json',
                width: 300,
                repeat: false,
              ),
            ),
            SizedBox(height: 10.0),
            Text('Easy Notes', style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w600, color: theme.colorScheme.tertiary)),
            SizedBox(height: 10.0),
            Text('Лучшие заметки на всей планете!', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,
                    color: theme.colorScheme.tertiary)),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(theme.colorScheme.primary)
              ),
              onPressed: () => _submitWelcomeScreen(context),
              child: Text('Вперед!', style: TextStyle(color: Colors.white, fontSize: 20.0),)
            )
          ],
        ),
      ),
    );
  }
  _submitWelcomeScreen(context) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('welcome', false);
    AutoRouter.of(context).replaceAll([DashboardRoute()]);
  }
}