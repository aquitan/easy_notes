import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/features/create/create.dart';
import 'package:easy_notes/features/dashboard/dashboard.dart';
import 'package:easy_notes/features/home/home.dart';
import 'package:easy_notes/features/profile/profile.dart';
import 'package:easy_notes/features/settings/settings.dart';
import 'package:easy_notes/features/welcome/welcome.dart';
import 'package:easy_notes/router/guards.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
		AutoRoute(page: HomeRoute.page, path: '/', initial: true, children: [
			AutoRoute(page: DashboardRoute.page, path: 'dashboard'),
			AutoRoute(page: CreateRoute.page, path: 'create'),
          AutoRoute(page: SettingsRoute.page, path: 'settings')
        ], guards: [
          WelcomeGuard()
        ]),
        AutoRoute(page: ProfileRoute.page, path: '/profile'),
        AutoRoute(page: WelcomeRoute.page)
  ];
}