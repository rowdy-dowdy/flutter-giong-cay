import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/config/app.dart';
import 'package:sample/firebase_options.dart';
import 'package:sample/services/firebase_cloud_messaging.dart';
import 'package:sample/services/theme_data.dart';
import 'package:sample/controllers/router_controller.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  final container = ProviderContainer();
  // 2. Use it to read the provider 
  // container.read(firebaseCloudMessagingServiceProvider);

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

    return MaterialApp.router(
      title: APP_NAME,
      scrollBehavior: const CupertinoScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: customTheme(),
      darkTheme: customTheme(themeMode: ThemeMode.dark),
      // themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}