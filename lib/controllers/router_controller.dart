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
import 'package:sample/pages/settings/SettingsEditPage.dart';

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
      routes: [
        GoRoute(
          name: "home",
          path: "/",
          builder: (context, state) => MainPage(key: state.pageKey, path: '/'),
          // pageBuilder: (context, state) => buildPageWithDefaultTransition(
          //   context: context, 
          //   state: state, 
          //   child: const HomePage(),
          // ),
          routes: [
          ]
        ),
        GoRoute(
          name: "settings",
          path: "/settings",
          builder: (context, state) => MainPage(key: state.pageKey, path: '/settings'),
          // pageBuilder: (context, state) => buildPageWithDefaultTransition(
          //   context: context, 
          //   state: state, 
          //   child: const SettingsPage(),
          // ),
          routes: [
            GoRoute(
              name: "settings-edit",
              path: "edit",
              builder: (context, state) => const SettingsEditPage(),
            ),
          ]
        ),
        GoRoute(
          name: "action",
          path: "/action",
          builder: (context, state) => MainPage(key: state.pageKey, path: '/action'),
          // pageBuilder: (context, state) => buildPageWithDefaultTransition(
          //   context: context, 
          //   state: state, 
          //   child: const ActionPage(),
          // ),
        ),
        GoRoute(
          name: "expert",
          path: "/expert",
          builder: (context, state) => MainPage(key: state.pageKey, path: '/expert'),
          // pageBuilder: (context, state) => buildPageWithDefaultTransition(
          //   context: context, 
          //   state: state, 
          //   child: const ExpertPage(),
          // ),
          routes: [
          ]
        ),
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