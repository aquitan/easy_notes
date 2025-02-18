import 'package:flutter/material.dart';

// light theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
		primary: Color.fromRGBO(234, 100, 43, 1),
		secondary: Colors.grey.shade400,
		inversePrimary: Colors.grey.shade800
  ),
);


// dark theme

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
		surface: Colors.grey.shade900,
		primary: Color.fromRGBO(234, 100, 43, 1),
		secondary: Colors.grey.shade700,
		inversePrimary: Colors.grey.shade300
	),
);
