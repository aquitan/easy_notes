import 'package:auto_route/auto_route.dart';
import 'package:easy_notes/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    bool showWelcome = pref.getBool('welcome') == null ? true : false;
    if (!showWelcome) {
      resolver.next(true);
    } else {
      router.push(WelcomeRoute());
    }
  }
}
