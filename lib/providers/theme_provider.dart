import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../helpers/custom_route.dart';

enum Themes {
  Dark,
  Light,
}

class ThemeProvider with ChangeNotifier {
  ThemeData lightTheme = ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionsBuilder(),
        TargetPlatform.iOS: CustomPageTransitionsBuilder(),
      },
    ),
    primarySwatch: Colors.teal,
    primaryColor: Colors.teal,
    accentColor: Colors.white,
    fontFamily: 'TitilliumWeb',
    textTheme: TextTheme(
      headline6: TextStyle(fontFamily: 'TitilliumWeb'),
    ),
  );
  ThemeData darkTheme = ThemeData(
    accentColor: Colors.lightBlueAccent,
    primarySwatch: Colors.grey,
    primaryColor: Colors.grey,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionsBuilder(),
        TargetPlatform.iOS: CustomPageTransitionsBuilder(),
      },
    ),
    fontFamily: 'TitilliumWeb',
    textTheme: TextTheme(
      headline6: TextStyle(fontFamily: 'TitilliumWeb'),
    ),
  );
  bool _darkTheme = false;
  ThemeData get theme {
    if (!_darkTheme) return lightTheme;
    return darkTheme;
  }

  bool get isDarkTheme {
    return _darkTheme;
  }

  void setTheme(bool newTheme) {
    _darkTheme = newTheme;
    notifyListeners();
  }
}
