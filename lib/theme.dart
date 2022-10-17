import 'package:flutter/material.dart';

// This is our  main focus
// Let's apply light and dark theme on our app
// Now let's add dark theme on our app

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    backgroundColor: Colors.black54,
    hoverColor: Colors.white,
    cardColor: Colors.black,
    canvasColor: Colors.transparent,
    textTheme: Theme.of(context).textTheme,

    // primarySwatch: Colors.orange,
    primaryColor: Colors.orange,
    accentColor: Colors.red,
    hintColor: Colors.orange[300],
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

ThemeData darkThemeData(BuildContext context) {
  // Bydefault flutter provie us light and dark theme
  // we just modify it as our need
  return ThemeData.dark().copyWith(
    backgroundColor: Colors.black54,
    cardColor: Colors.black,
    hoverColor: Colors.white,
    canvasColor: Colors.transparent,
    textTheme: Theme.of(context).textTheme,

    // primarySwatch: Colors.orange,
    primaryColor: Colors.orange,
    accentColor: Colors.red,
    hintColor: Colors.orange[300],
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

final appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
