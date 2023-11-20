import 'package:hive_flutter/hive_flutter.dart';
import 'package:spaced_repetition_notes/app/extention/note_id_extention.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  Note({required this.time, required this.noteItemList}) : id = time.toNoteId();

  @HiveField(0)
  int id;

  @HiveField(1)
  final DateTime time;

  @HiveField(2)
  HiveList noteItemList;
}
