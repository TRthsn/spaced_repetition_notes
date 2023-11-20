import 'package:spaced_repetition_notes/service/modal/note.dart';

abstract class CubitBaseState {}

class CubitInitialState extends CubitBaseState {}

class CubitLoadingState extends CubitBaseState {}

class CubitAddItemState extends CubitBaseState {}

class CubitRemoveItemState extends CubitBaseState {}

class CubitPressStepState extends CubitBaseState {}

class CubitSuccessState extends CubitBaseState {
  CubitSuccessState({
    required this.allItems,
  });
  final Map<int, Note> allItems;
}

class CubitErrorState extends CubitBaseState {
  CubitErrorState({required this.errorText});
  final String errorText;
}
