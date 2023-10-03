import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/config/app.dart';
import 'package:sample/firebase_options.dart';
import 'package:sample/pages/LoadingPage.dart';
import 'package:sample/services/firebase_cloud_messaging.dart';
import 'package:sample/services/shared_prefs.dart';
import 'package:sample/services/theme_data.dart';
import 'package:sample/controllers/router_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  final prefs = await SharedPreferences.getInstance();

  final theme = await loadThemeMode(prefs);

  final container = ProviderContainer(
    overrides: [
      sharedPrefsProvider.overrideWithValue(prefs)
    ]
  );
  // container.read(firebaseCloudMessagingServiceProvider);
  container.read(themeDataProvider.notifier).updateThemeModel(theme);

  runApp(UncontrolledProviderScope(
    container: container,
    child: EasyLocalization(
      supportedLocales: const [Locale('vi'), Locale('en')],
      path: 'assets/translations', // <-- change the path of the translation files 
      fallbackLocale: const Locale('vi'),
      startLocale: const Locale('vi'),
      child: const MyApp()
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeData = ref.watch(themeDataProvider);
    
    return MaterialApp.router(
      title: APP_NAME,
      scrollBehavior: const CupertinoScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: themeData.lightTheme,
      darkTheme: themeData.darkTheme,
      themeMode: themeData.themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

extension StringExtension on String {
  String toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}