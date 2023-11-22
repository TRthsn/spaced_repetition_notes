import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spaced_repetition_notes/app/theme/theme_dark.dart';
import 'package:spaced_repetition_notes/app/theme/theme_light.dart';
import 'package:spaced_repetition_notes/features/home_page/view/home_page_view.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/note_cubit.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/theme_cubit.dart';
import 'package:spaced_repetition_notes/main_init.dart';
import 'package:spaced_repetition_notes/service/cache_manager.dart';

Future<void> main() async {
  await MainInit().startProject();
  runApp(
    BlocProvider(
      create: (context) =>
          ThemeCubit(CacheManager.init(), CacheManager.init().getTheme()),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: CustomDarkTheme().themeData,
          theme: CustomLightTheme().themeData,
          themeMode: state,
          home: BlocProvider(
            create: (context) =>
                NoteCubit(CacheManager.init())..getWeekDayItems(),
            child: const HomePageView(),
          ),
        );
      },
    );
  }
}
