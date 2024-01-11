import 'package:flutter/material.dart';

class AppTheme {

  List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.cyan,
      Colors.amber,
      Colors.lime,
      Colors.lightBlue,
      Colors.lightGreen,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.brown,
      Colors.white,
  ];

  ThemeData getTheme( int colorSelected ){

    return ThemeData(
      colorSchemeSeed: colors[colorSelected],
      useMaterial3: true,
    );

  }

}