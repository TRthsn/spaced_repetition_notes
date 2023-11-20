import 'package:flutter/material.dart';
import 'package:spaced_repetition_notes/features/home_page/view/widgets/note_add_and_remove_floating_button.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NoteAddAndRemoveFloatingButtons(),
    );
  }
}
