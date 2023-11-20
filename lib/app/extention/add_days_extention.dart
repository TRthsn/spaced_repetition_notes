extension AddDaysExtention on DateTime {
  DateTime addDays(int day) {
    return add(Duration(days: day));
  }
}
