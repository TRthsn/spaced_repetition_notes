import 'package:hive_flutter/hive_flutter.dart';

part 'note_item.g.dart';

@HiveType(typeId: 0)
class NoteItem extends HiveObject {
  NoteItem({required this.iconCode, required this.time, required this.message});

  @HiveField(0)
  final int iconCode;

  @HiveField(1)
  final DateTime time;

  @HiveField(2)
  final String message;
}
