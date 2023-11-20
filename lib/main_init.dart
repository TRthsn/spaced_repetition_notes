import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spaced_repetition_notes/cubit_observer.dart';
import 'package:spaced_repetition_notes/service/modal/note.dart';
import 'package:spaced_repetition_notes/service/modal/note_item.dart';

final class MainInit {
  Future<void> startProject() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
    Hive.registerAdapter(NoteItemAdapter());
    await Hive.openBox<NoteItem>('NoteItems');
    await Hive.openBox<Note>('Notes');
    Bloc.observer = const CubitObserver();
  }
}
