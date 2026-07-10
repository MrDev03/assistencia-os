import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightThemeColor (Color primaryColor) {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF2F5F9),
    cardColor: Colors.white,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      surface: Colors.white,
      onSurface: Colors.black,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF2F5F9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.5), width: 1),
      ),
    ),

    dialogTheme: const DialogThemeData(
      backgroundColor: Colors.white,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    // iconButtonTheme: IconButtonThemeData(
    //   style: ButtonStyle(
    //     foregroundColor: WidgetStateProperty.all<Color>(themeProvider.corPrimaria),
    //   ),
    // ),
    appBarTheme: const AppBarTheme(
      titleSpacing: 2,
      scrolledUnderElevation: 0,
      //actionsPadding: EdgeInsets.only(right: 10),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(25),
      //     bottomRight: Radius.circular(25),
      //   ),
      // ),
      backgroundColor: Color(0xFFF2F5F9),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      actionsPadding: EdgeInsets.zero,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFF2F5F9)
        // statusBarColor: primaryColor,
        // statusBarIconBrightness: Brightness.light,
        // systemNavigationBarColor: Colors.white,
        // systemNavigationBarIconBrightness: Brightness.dark,
      ),
      //foregroundColor: Colors.white,
    ),
    chipTheme: TemasPadrao.chipTheme(primaryColor),
    useMaterial3: true,
  );
}

ThemeData darkThemeColor (Color primaryColor) {
  return ThemeData(
    //themeProvider.corPrimaria.withValues(alpha: 0.1),
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    cardColor: const Color(0xFF1E1E1E),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: primaryColor,
      surface: Colors.black,
      onSurface: Colors.white,
    ),

    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        )
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.5), width: 1),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      textColor: Colors.white,
    ),
    // iconButtonTheme: IconButtonThemeData(
    //   style: ButtonStyle(
    //     foregroundColor: WidgetStateProperty.all<Color>(themeProvider.corPrimaria),
    //   ),
    // ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
    ),
    appBarTheme: const AppBarTheme(
      titleSpacing: 2,
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      actionsPadding: EdgeInsets.zero,
      //actionsPadding: EdgeInsets.only(right: 10),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      //foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Color(0xFF000000),
        // statusBarBrightness: Brightness.dark,
        // statusBarColor: primaryColor.withValues(alpha: 0.1),
        // statusBarIconBrightness: Brightness.light,
        // systemNavigationBarColor: Colors.black,
        // systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    chipTheme: TemasPadrao.chipTheme(primaryColor, labelColor: Colors.white70),
    useMaterial3: true,
  );
}

class TemasPadrao {
  static ChipThemeData chipTheme(Color primaryColor, {Color? labelColor}) {
    return ChipThemeData(
      backgroundColor: primaryColor.withValues(alpha: 0.1),
      selectedColor: primaryColor,
      labelStyle: TextStyle(
        color: labelColor ?? primaryColor,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      side: BorderSide.none,
    );
  }
}
