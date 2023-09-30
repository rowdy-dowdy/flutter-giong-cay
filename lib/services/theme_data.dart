// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  primary: Color(0xFF6750a4),
  onPrimary: Color(0xFFffffff),
  primaryContainer: Color(0xFFe9ddff),
  onPrimaryContainer: Color(0xFF22005d),

  secondary: Color(0xFF6750a4),
  onSecondary: Color(0xFFffffff),
  secondaryContainer: Color(0xFFe9ddff),
  onSecondaryContainer: Color(0xFF22005d),

  background: Color(0xFFfffbff),
  onBackground: Color(0xFF1c1b1e),
  surface: Color(0xFFfffbff),
  onSurface: Color(0xFF1c1b1e),
  
  outline: Color(0xFF7a757f),
  surfaceVariant: Color(0xFFe7e0eb),
  onSurfaceVariant: Color(0xFF49454e),

  error: Color(0xFFba1a1a),
  onError: Color(0xFFffffff),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  primary: Color(0xFFcfbcff),
  onPrimary: Color(0xFF381e72),
  primaryContainer: Color(0xFF4f378a),
  onPrimaryContainer: Color(0xFFe9ddff),

  secondary: Color(0xFFcbc2db),
  onSecondary: Color(0xFF332d41),
  secondaryContainer: Color(0xFF4a4458),
  onSecondaryContainer: Color(0xFFe8def8),

  background: Color(0xFF1c1b1e),
  onBackground: Color(0xFFe6e1e6),
  surface: Color(0xFF1c1b1e),
  onSurface: Color(0xFFe6e1e6),
  
  outline: Color(0xFF948f99),
  surfaceVariant: Color(0xFF49454e),
  onSurfaceVariant: Color(0xFFcac4cf),

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
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     // backgroundColor: primary2,
    //     minimumSize: const Size(double.infinity, 48),
    //     elevation: 0.0,
    //     shadowColor: Colors.transparent,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(5.0),
    //     ),
    //     backgroundColor: primary,
    //     foregroundColor : Colors.white,
    //   ),
    // ),
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
    // navigationBarTheme: const NavigationBarThemeData(
    //   indicatorColor: primary,
    //   // labelTextStyle: MaterialStateProperty.all(
    //   //   const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)
    //   // ),
    //   // elevation: 0,
    // ),
  );
}

final customLightTheme = CustomThemeData(
  padding: 16,
);

final customDarkTheme = CustomThemeData();

extension CustomTheme on ThemeData {
  CustomThemeData get custom => 
    brightness == Brightness.dark ? customDarkTheme : customLightTheme;
}

class CustomThemeData {
  final double padding;

  CustomThemeData({
    this.padding = 16,
  });
}