import 'package:flutter/material.dart';
import 'package:spaced_repetition_notes/app/constants/constants_decoration.dart';
import 'package:spaced_repetition_notes/app/constants/constants_string.dart';
import 'package:spaced_repetition_notes/service/modal/note_item.dart';

class DialogAddButton extends StatelessWidget {
  const DialogAddButton({
    required this.textEditingController,
    required this.selectedIconData,
    super.key,
  });

  final TextEditingController textEditingController;
  final IconData? selectedIconData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
            MediaQuery.of(context).size.width / 2,
            DecorationConstants.showDialogButtonHeight,
          ),
          backgroundColor:
              DecorationConstants.showDialogEkleButtonBackgroundColor,
          shape: const RoundedRectangleBorder(),
        ),
        highlightColor: DecorationConstants.showDialogEkleButtonHighlightColor,
        color: DecorationConstants.showDialogEkleButtonColor,
        onPressed: () {
          final item = NoteItem(
            time: DateTime.now(),
            message: textEditingController.text,
            iconCode: selectedIconData?.codePoint ?? Icons.favorite.codePoint,
          );
          textEditingController.clear();
          Navigator.of(context).pop(item);
        },
        icon: const Row(
          children: [
            Icon(Icons.save),
            SizedBox(
              width: DecorationConstants.showDialogSmallHeight,
            ),
            Text(StringConstants.showDialogSave),
          ],
        ),
      ),
    );
  }
}
