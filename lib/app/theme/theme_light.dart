import 'package:flutter/material.dart';
import 'package:spaced_repetition_notes/app/theme/theme_base.dart';
import 'package:spaced_repetition_notes/app/theme/theme_color_schemes.dart';

class CustomLightTheme implements ThemeBase {
  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        colorScheme: AppColorSchemes.light,
      );
}
