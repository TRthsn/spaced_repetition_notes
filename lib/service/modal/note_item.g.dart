// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteItemAdapter extends TypeAdapter<NoteItem> {
  @override
  final int typeId = 0;

  @override
  NoteItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteItem(
      iconCode: fields[0] as int,
      time: fields[1] as DateTime,
      message: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.iconCode)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
