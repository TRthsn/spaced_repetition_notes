import 'package:hive/hive.dart';
import 'package:spaced_repetition_notes/app/extention/note_id_extention.dart';
import 'package:spaced_repetition_notes/service/modal/note.dart';
import 'package:spaced_repetition_notes/service/modal/note_item.dart';

class CacheManager {
  CacheManager._();
  factory CacheManager.init() => _cacheManager ??= CacheManager._();
  static CacheManager? _cacheManager;
  DateTime currentNoteTime = DateTime.now();

  final noteItemBox = Hive.box<NoteItem>('NoteItems');
  final noteBox = Hive.box<Note>('Notes');
  final themeBox = Hive.box<bool>('Theme');

  Future<void> addNote(NoteItem item) async {
    final currentDayNote = noteBox.get(item.time.toNoteId());
    if (currentDayNote == null) {
      final currentNote =
          Note(time: item.time, noteItemList: HiveList(noteItemBox));

      await noteBox.put(item.time.toNoteId(), currentNote);
      await noteItemBox.add(item);
      currentNote.noteItemList.add(item);
      await currentNote.save();
    } else {
      await noteItemBox.add(item);
      currentDayNote.noteItemList.add(item);
      await currentDayNote.save();
    }
  }

  void setTheme(bool isLightTheme) {
    themeBox.put('theme', isLightTheme);
  }

  bool getTheme() {
    return themeBox.get('theme') ?? false;
  }

  void removeNote(NoteItem item) {
    final currentDayNote = noteBox.get(item.time.toNoteId());
    currentDayNote?.noteItemList.remove(item);
    currentDayNote?.save();
  }

  Future<void> clearNotes() async {
    await noteItemBox.clear();
  }

  HiveList<HiveObjectMixin>? getCurrentDayNotes(DateTime time) {
    final currentDayNotes = noteBox.get(time.toNoteId());
    if (currentDayNotes != null) {
      return currentDayNotes.noteItemList;
    } else {
      return null;
    }
  }
}
