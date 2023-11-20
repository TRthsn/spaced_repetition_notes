import 'package:flutter/material.dart';
import 'package:spaced_repetition_notes/app/theme/theme_dark.dart';
import 'package:spaced_repetition_notes/app/theme/theme_light.dart';
import 'package:spaced_repetition_notes/features/home_page/view/home_page_view.dart';
import 'package:spaced_repetition_notes/main_init.dart';

Future<void> main() async {
  await MainInit().startProject();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: CustomDarkTheme().themeData,
      theme: CustomLightTheme().themeData,
      themeMode: ThemeMode.light,
      home: HomePageView(),
    );
  }
}
