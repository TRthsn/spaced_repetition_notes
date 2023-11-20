import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spaced_repetition_notes/app/constants/constants_decoration.dart';
import 'package:spaced_repetition_notes/app/constants/constants_string.dart';
import 'package:spaced_repetition_notes/features/home_page/view/widgets/dialog_add_button.dart';
import 'package:spaced_repetition_notes/features/home_page/view/widgets/dialog_add_icon_button.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/note_cubit.dart';
import 'package:spaced_repetition_notes/service/cache_manager.dart';
import 'package:spaced_repetition_notes/service/modal/note_item.dart';

class NoteAddAndRemoveFloatingButtons extends StatelessWidget {
  NoteAddAndRemoveFloatingButtons({
    super.key,
  });
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () async {
            final item = await addNoteItemShowDialog(context);
            if (item is NoteItem) {
              await context.read<NoteCubit>().addItem(item);
            }
          },
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () {
            context.read<NoteCubit>().clearItems();
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
                              child: Icon(
                                context.watch<NoteCubit>().selectedIconData,
                                size: DecorationConstants.showDialogIconSize,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DialogAddIconButton(
                                context: context,
                                setState: setState,
                              ),
                              const SizedBox(
                                width:
                                    DecorationConstants.showDialogSmallHeight,
                              ),
                              DialogAddButton(
                                textEditingController: textEditingController,
                                selectedIconData:
                                    context.watch<NoteCubit>().selectedIconData,
                              ),
                            ],
                          ),
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
}
