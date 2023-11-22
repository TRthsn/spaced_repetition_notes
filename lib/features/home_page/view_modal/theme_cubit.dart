import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spaced_repetition_notes/app/extention/note_id_extention.dart';

import 'package:spaced_repetition_notes/service/cache_manager.dart';
import 'package:spaced_repetition_notes/service/modal/note.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this.cacheManager, this.currentMode)
      : super(currentMode ? ThemeMode.light : ThemeMode.dark);
  final bool currentMode;
  final CacheManager cacheManager;
  void changeTheme() {
    if (state == ThemeMode.light) {
      cacheManager.setTheme(false);
      emit(ThemeMode.dark);
    } else {
      cacheManager.setTheme(true);
      emit(ThemeMode.light);
    }
  }
}
