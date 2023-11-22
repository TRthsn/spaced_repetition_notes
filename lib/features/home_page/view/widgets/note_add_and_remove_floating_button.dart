import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:spaced_repetition_notes/app/constants/constants_decoration.dart';
import 'package:spaced_repetition_notes/app/constants/constants_string.dart';
import 'package:spaced_repetition_notes/features/home_page/view/widgets/dialog_add_icon_button.dart';
import 'package:spaced_repetition_notes/features/home_page/view/widgets/dialog_spaced_add_button.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/note_cubit.dart';
import 'package:spaced_repetition_notes/service/cache_manager.dart';
import 'package:spaced_repetition_notes/service/modal/note_item.dart';

class NoteAddAndRemoveFloatingButtons extends StatelessWidget {
  NoteAddAndRemoveFloatingButtons({
    required this.textEditingController,
    super.key,
  });
  final TextEditingController textEditingController;
  bool isSaveButton = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () async {
            final item = await addNoteItemShowDialog(context);
            if (item is NoteItem) {
              if (isSaveButton) {
                await context.read<NoteCubit>().addItem(item);
                isSaveButton = false;
              } else {
                await context.read<NoteCubit>().addSpacedItem(item);
              }
            } else {}
          },
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () async {
            final removeAll = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(StringConstants.alertDialogClearAllData),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Icon(Icons.done),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            );
            removeAll == true
                ? await context.read<NoteCubit>().clearItems()
                : null;
          },
          child: const Icon(Icons.cleaning_services),
        ),
      ],
    );
  }

  Future<dynamic> addNoteItemShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => NoteCubit(CacheManager.init()),
          child: Scaffold(
            body: Padding(
              padding: DecorationConstants.showDialogPadding,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Center(
                    child: SizedBox(
                      height: DecorationConstants.showDialogHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: const Duration(
                                milliseconds: DecorationConstants
                                    .animatedSwitcherDuration,
                              ),
                              child: InkWell(
                                onTap: () async {
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

                                    return context
                                        .read<NoteCubit>()
                                        .selectedIcon = Icon(
                                      context
                                          .read<NoteCubit>()
                                          .selectedIconData,
                                    );
                                  }

                                  await pickIcon(context);
                                },
                                child: Icon(
                                  context.watch<NoteCubit>().selectedIconData,
                                  size: DecorationConstants.showDialogIconSize,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: DecorationConstants.showDialogMediumHeight,
                          ),
                          TextField(
                            maxLines: 2,
                            decoration: const InputDecoration(
                              labelText: StringConstants.showDialogNoteGiriniz,
                              border: OutlineInputBorder(),
                            ),
                            controller: textEditingController,
                          ),
                          const SizedBox(
                            height: DecorationConstants.showDialogMediumHeight,
                          ),
                          DialogButtons(context, setState),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Row DialogButtons(BuildContext context, StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: DialogAddIconButton(
            context: context,
            setState: setState,
          ),
        ),
        const SizedBox(
          width: DecorationConstants.showDialogSmallHeight,
        ),
        Expanded(
          child: DialogSpacedAddButton(
            textEditingController: textEditingController,
            selectedIconData: context.watch<NoteCubit>().selectedIconData,
          ),
        ),
        const SizedBox(
          width: DecorationConstants.showDialogSmallHeight,
        ),
        Expanded(
          child: DialogAddButton(context),
        ),
      ],
    );
  }

  IconButton DialogAddButton(BuildContext context) {
    return IconButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          MediaQuery.of(context).size.width / 3,
          DecorationConstants.showDialogButtonHeight,
        ),
        backgroundColor:
            DecorationConstants.showDialogEkleButtonBackgroundColor,
        shape: const RoundedRectangleBorder(),
      ),
      highlightColor:
          DecorationConstants.showDialogSpacedEkleButtonHighlightColor,
      color: DecorationConstants.showDialogSpacedEkleButtonColor,
      onPressed: () {
        final item = NoteItem(
          time: context.read<NoteCubit>().cacheManager.currentNoteTime,
          message: textEditingController.text,
          iconCode: context.read<NoteCubit>().selectedIconData?.codePoint ??
              Icons.favorite.codePoint,
        );
        textEditingController.clear();
        isSaveButton = true;

        Navigator.of(context).pop<NoteItem>(item);
      },
      icon: const FittedBox(
        child: Row(
          children: [
            Icon(Icons.save_as_outlined),
            SizedBox(
              width: DecorationConstants.showDialogSmallHeight,
            ),
            Text(
              StringConstants.showDialogSave,
            ),
          ],
        ),
      ),
    );
  }
}
