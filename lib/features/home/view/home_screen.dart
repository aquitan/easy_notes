import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        DashboardRoute(),
        CreateRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: BottomNavigationBar(
              onTap: (value) => _onTabOpened(value, tabsRouter),
              type: BottomNavigationBarType.fixed,
              currentIndex: tabsRouter.activeIndex,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Главная'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.create),
                  label: 'Создать'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle),
                  label: 'Профиль')
              ]
            ),
          ),
        );
      },
    );
  }
  void _onTabOpened(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}