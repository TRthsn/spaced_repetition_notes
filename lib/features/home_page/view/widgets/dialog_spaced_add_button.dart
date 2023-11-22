import 'package:flutter/material.dart';
import 'package:spaced_repetition_notes/app/constants/constants_decoration.dart';
import 'package:spaced_repetition_notes/app/constants/constants_string.dart';
import 'package:spaced_repetition_notes/service/modal/note_item.dart';

class DialogSpacedAddButton extends StatelessWidget {
  const DialogSpacedAddButton({
    required this.textEditingController,
    required this.selectedIconData,
    super.key,
  });

  final TextEditingController textEditingController;
  final IconData? selectedIconData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          MediaQuery.of(context).size.width / 3,
          DecorationConstants.showDialogButtonHeight,
        ),
        backgroundColor:
            DecorationConstants.showDialogSpacedEkleButtonBackgroundColor,
        shape: const RoundedRectangleBorder(),
      ),
      highlightColor:
          DecorationConstants.showDialogSpacedEkleButtonHighlightColor,
      color: DecorationConstants.showDialogSpacedEkleButtonColor,
      onPressed: () {
        final item = NoteItem(
          time: DateTime.now(),
          message: textEditingController.text,
          iconCode: selectedIconData?.codePoint ?? Icons.favorite.codePoint,
        );
        textEditingController.clear();
        Navigator.of(context).pop(item);
      },
      icon: const FittedBox(
        child: Row(
          children: [
            Icon(Icons.save),
            SizedBox(
              width: DecorationConstants.showDialogSmallHeight,
            ),
            Text(StringConstants.showDialogSpacedSave),
          ],
        ),
      ),
    );
  }
}
