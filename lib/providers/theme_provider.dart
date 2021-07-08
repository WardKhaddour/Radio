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
  ThemeData darkTheme = ThemeData.dark()
      .copyWith(primaryColor: Colors.black, accentColor: Colors.black12);

  String _theme = 'Light';
  ThemeData get theme {
    if (_theme == describeEnum(Themes.Light)) return lightTheme;
    return darkTheme;
  }

  void setTheme(String newTheme) {
    _theme = newTheme;
    notifyListeners();
  }
}
