import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/controllers/auth_controller.dart';
import 'package:sample/models/auth_model.dart';
import 'package:sample/pages/ErrorPage.dart';
import 'package:sample/pages/MainPage.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/pages/LoadingPage.dart';
import 'package:sample/pages/LoginPage.dart';
import 'package:sample/pages/calendar/CalendarPage.dart';
import 'package:sample/pages/home/HomePage.dart';
import 'package:sample/pages/planting/PlantingPage.dart';
import 'package:sample/pages/settings/SettingsEditPage.dart';
import 'package:sample/pages/settings/SettingsPage.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  final List<String> loginPages = ["/login"];

  RouterNotifier(this._ref) {
    _ref.listen(authControllerProvider, 
    (_, __) => notifyListeners());
  }

  String? _redirectLogin(_, GoRouterState state) {
    final auth = _ref.read(authControllerProvider);
    
    if (auth.authState == AuthState.initial) return null;

    final areWeLoginIn = loginPages.indexWhere((e) => e == state.matchedLocation);

    if (auth.authState != AuthState.login) {
      return areWeLoginIn >= 0 ? null : loginPages[0];
    }

    if (areWeLoginIn >= 0 || state.matchedLocation == "/loading") {
      return '/';
    }

    return null;    
  }

  List<RouteBase> get _routers => [
    GoRoute(
      name: "loading",
      path: "/loading",
      builder: (context, state) => const LoadingPage(),
    ),
    GoRoute(
      name: "login",
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),

    // pages logged
    ShellRoute(
      builder: (context, state, child) => child,
      navigatorKey: _rootNavigatorKey,
      routes: [
        ShellRoute(
          builder: (context, state, child) => MainPage(location: state.uri.toString()),
          routes: [
            GoRoute(
              name: "home",
              path: "/",
              builder: (context, state) => const SizedBox(),
            ),
            GoRoute(
              name: "settings",
              path: "/settings",
              builder: (context, state) => throw "",
              routes: [
                GoRoute(
                  name: "settings-edit",
                  path: "edit",
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const SettingsEditPage(),
                ),
              ]
            ),
            GoRoute(
              name: "calendar",
              path: "/calendar",
              builder: (context, state) => throw "",
            ),
            GoRoute(
              name: "planting",
              path: "/planting",
              builder: (context, state) => const PlantingPage(),
            ),
          ]
        )
      ]
    ),
  ];
}

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    initialLocation: "/loading",
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: router._redirectLogin,
    routes: router._routers,
    errorBuilder: ((context, state) => const ErrorPage() ),
  );
});