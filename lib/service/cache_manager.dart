import 'package:hive/hive.dart';
import 'package:spaced_repetition_notes/service/modal/note.dart';
import 'package:spaced_repetition_notes/service/modal/note_item.dart';

class CacheManager {
  CacheManager._();
  factory CacheManager.init() => _cacheManager ??= CacheManager._();
  static CacheManager? _cacheManager;

  final noteItemBox = Hive.box<NoteItem>('NoteItems');
  final noteBox = Hive.box<Note>('NoteItems');
}
