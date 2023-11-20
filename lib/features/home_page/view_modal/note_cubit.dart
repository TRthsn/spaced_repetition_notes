import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/note_cubit_state.dart';
import 'package:spaced_repetition_notes/service/cache_manager.dart';
import 'package:spaced_repetition_notes/service/modal/note.dart';
import 'package:spaced_repetition_notes/service/modal/note_item.dart';

class NoteCubit extends Cubit<CubitBaseState> {
  NoteCubit(this.cacheManager) : super(CubitInitialState()) {}
  final CacheManager cacheManager;
  final time = DateTime.now();
  int currentStep = DateTime.now().weekday;
  IconData? selectedIconData;
  Icon? selectedIcon;

  ///I have collected the note lists here
  final weekNotes = <int, Note>{};

  Future<void> addItem(NoteItem note) async {
    Future<void> addtreeItems(int nextDay) async {
      await cacheManager.addNote(
        NoteItem(
          iconCode: note.iconCode,
          time: time.add(Duration(days: nextDay)),
          message: note.message,
        ),
      );
    }

    ///I added a note for 1,3,6 day later
    await addtreeItems(1);
    await addtreeItems(3);
    await addtreeItems(6);

    emit(CubitAddItemState());
    emit(CubitSuccessState(allItems: weekNotes));
  }

  void refreshItems() {
    emit(CubitLoadingState());
  }

  void removeItems(NoteItem item) {
    cacheManager.removeNote(item);
    emit(CubitRemoveItemState());
  }

  Future<void> clearItems() async {
    await cacheManager.clearNotes();
    emit(CubitRemoveItemState());
  }

  void changeStep(int step) {
    currentStep = step;
    emit(CubitPressStepState());
  }

  void getWeekDayItems() {
    emit(CubitLoadingState());
    try {
      for (var dayLater = 0; dayLater < 7; dayLater++) {
        final dayItems =
            cacheManager.getCurrentDayNotes(time.add(Duration(days: dayLater)));
        if (dayItems == null) {
          weekNotes[time.add(Duration(days: dayLater)).weekday] = Note(
            time: time,
            noteItemList: HiveList(cacheManager.noteItemBox),
          );
        } else {
          weekNotes[time.add(Duration(days: dayLater)).weekday] =
              Note(time: time, noteItemList: dayItems);
        }
      }
      emit(CubitSuccessState(allItems: weekNotes));
    } catch (e) {
      emit(CubitErrorState(errorText: 'We received an error pulling data'));
    }
  }
}
