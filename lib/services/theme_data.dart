// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  primary: Color(0xFF386a20),
  onPrimary: Color(0xFFffffff),
  primaryContainer: Color(0xFFb7f397),
  onPrimaryContainer: Color(0xFF042100),

  secondary: Color(0xFF55624c),
  onSecondary: Color(0xFFffffff),
  secondaryContainer: Color(0xFFd9e7cb),
  onSecondaryContainer: Color(0xFF131f0d),

  background: Color(0xFFedefe5),
  surface: Color.fromRGBO(252, 252, 239, 1),
  // surface: Color(0xFFf8faf0),
  onBackground: Color(0xFF1a1c18),
  onSurface: Color(0xFF1a1c18),
  onSurfaceVariant: Color(0xFF43483e),
  
  outline: Color(0xFF74796d),
  outlineVariant: Color(0xFFc3c8bb),

  error: Color(0xFFba1a1a),
  onError: Color(0xFFffffff),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  primary: Color(0xFF9dd67d),
  onPrimary: Color(0xFF113800),
  primaryContainer: Color(0xFF205106),
  onPrimaryContainer: Color(0xFFb8f397),

  secondary: Color(0xFFbdcbb0),
  onSecondary: Color(0xFF283420),
  secondaryContainer: Color(0xFF3e4a35),
  onSecondaryContainer: Color(0xFFd9e7cb),

  background: Color(0xFF1e211a),
  surface: Color(0xFF11140e),
  onBackground: Color(0xFFe3e3dc),
  onSurface: Color(0xFFe3e3dc),
  onSurfaceVariant: Color(0xFFc3c8bb),

  outline: Color(0xFF948f99),
  outlineVariant: Color(0xFF43483e),

  error: Color(0xFFffb4ab),
  onError: Color(0xFF690005),
);

ThemeData customTheme ({ThemeMode? themeMode}) {
  final colorScheme = (themeMode == ThemeMode.dark) ? darkColorScheme : lightColorScheme;

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      }
    ),

    // scaffoldBackgroundColor: const Color(0xfff0f2f5),
    appBarTheme: AppBarTheme(
      // color: Colors.white,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: colorScheme.onBackground,
        fontSize: 16, 
        fontWeight: FontWeight.w600
      ),
      // iconTheme: const IconThemeData(
      //   size: 20,
      // ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // backgroundColor: primary2,
        minimumSize: const Size(double.infinity, 48),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor : colorScheme.onPrimary,
      ),
    ),
    // // textButtonTheme: TextButtonThemeData(
    // //   style: TextButton.styleFrom(
    // //     // foregroundColor: primary
    // //   )
    // // ),
    // // textTheme: const TextTheme(
    // //   // bodyMedium: TextStyle(color: Colors.grey[900]!),
    // // ),
    // // iconTheme: IconThemeData(
    // //   color: Colors.grey[900]
    // // ),
    // inputDecorationTheme: InputDecorationTheme(
    //   labelStyle: TextStyle(color: Colors.grey[700]),
    //   floatingLabelStyle: const TextStyle(color: primary),
    //   border: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.grey[400]!),
    //     borderRadius: BorderRadius.circular(6)
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.grey[400]!),
    //     borderRadius: BorderRadius.circular(6)
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderSide: const BorderSide(color: Colors.red),
    //     borderRadius: BorderRadius.circular(6)
    //   ),
      
    //   isDense: true,
    //   contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12.0),
    // ),
    // // tabBarTheme: TabBarTheme(
    // //   labelPadding: const EdgeInsets.symmetric(horizontal: 0.0),
    // //   indicatorColor: Colors.transparent,
    // //   dividerColor: Colors.transparent,
    // //   indicatorSize: TabBarIndicatorSize.label,
    // //   indicator: BoxDecoration(
    // //     borderRadius: BorderRadius.circular(5),
    // //     color: Colors.white,
    // //     boxShadow: [
    // //       BoxShadow(
    // //         color: Colors.black.withOpacity(0.2),
    // //         spreadRadius: 1,
    // //         blurRadius: 5,
    // //         offset: const Offset(0, 1), // changes position of shadow
    // //       ),
    // //     ]
    // //   ),
    // //   labelColor: primary,
    // //   unselectedLabelColor: Colors.black,
    // // ),
    navigationBarTheme: const NavigationBarThemeData(
      // indicatorColor: primary,
      // labelTextStyle: MaterialStateProperty.all(
      //   const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)
      // ),
      elevation: 0,
    ),
  );
}

final customLightTheme = CustomThemeData(
  surfaceContainerLowest: Color(0xFFFCFCEF)
);

final customDarkTheme = CustomThemeData(
  surfaceContainerLowest: Color(0xFF11140e)
);

extension CustomTheme on ThemeData {
  CustomThemeData get custom => 
    brightness == Brightness.dark ? customDarkTheme : customLightTheme;
}

class CustomThemeData {
  final double padding;
  final Color surfaceContainerLowest;

  CustomThemeData({
    this.padding = 16,
    required this.surfaceContainerLowest
  });
}