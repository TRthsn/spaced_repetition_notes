extension NoteItemIdExtention on DateTime {
  int toNoteId() {
    final year = this.year * 10000;
    final mounth = month * 100;
    final day = this.day;
    return year + mounth + day;
  }
}
