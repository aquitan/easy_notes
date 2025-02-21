import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        DashboardRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final theme = Theme.of(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AutoRouter.of(context).push(CreateRoute());
            },
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: child,
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: theme.cardColor,
                onTap: (value) => _onTabOpened(value, tabsRouter),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: theme.colorScheme.primary,
                currentIndex: tabsRouter.activeIndex,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Главная'),

                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Настройки')
              ]),
        );
      },
    );
  }
  void _onTabOpened(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}