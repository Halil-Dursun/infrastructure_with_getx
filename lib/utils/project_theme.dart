

import 'package:flutter/material.dart';
import 'package:local_project/utils/project_colors.dart';

class ProjectThemes{
  static ThemeData projectDarkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
  );
  static ThemeData projectLightTheme = ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: ProjectColor.cyanColor,
          elevation: 0,
        ),
  );
}