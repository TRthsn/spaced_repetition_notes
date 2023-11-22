import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:spaced_repetition_notes/app/constants/constants_decoration.dart';
import 'package:spaced_repetition_notes/app/constants/constants_string.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/note_cubit.dart';

class DialogAddIconButton extends StatelessWidget {
  const DialogAddIconButton({
    required this.context,
    required this.setState,
    super.key,
  });

  final BuildContext context;
  final StateSetter setState;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            DecorationConstants.showDialogIconButtonBackgroundColor,
        fixedSize: Size(
          MediaQuery.of(context).size.width / 3,
          DecorationConstants.showDialogButtonHeight,
        ),
        shape: const RoundedRectangleBorder(),
      ),
      highlightColor: DecorationConstants.showDialogIconButtonHighlightColor,
      color: DecorationConstants.showDialogIconButtonColor,
      onPressed: () async {
        Future<Icon> pickIcon(
          BuildContext context,
        ) async {
          context.read<NoteCubit>().selectedIconData =
              await FlutterIconPicker.showIconPicker(
            context,
            iconPackModes: [
              IconPack.material,
            ],
          );
          setState(() {});

          return context.read<NoteCubit>().selectedIcon =
              Icon(context.read<NoteCubit>().selectedIconData);
        }

        await pickIcon(context);
      },
      icon: const FittedBox(
        child: Row(
          children: [
            Icon(Icons.add_a_photo),
            SizedBox(
              width: DecorationConstants.showDialogSmallHeight,
            ),
            Text(
              StringConstants.showDialogIconGiriniz,
            ),
          ],
        ),
      ),
    );
  }
}
