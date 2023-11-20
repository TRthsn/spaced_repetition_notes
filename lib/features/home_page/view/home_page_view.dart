import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:spaced_repetition_notes/app/constants/constants_decoration.dart';
import 'package:spaced_repetition_notes/app/constants/constants_string.dart';
import 'package:spaced_repetition_notes/app/constants/constants_text_style.dart';
import 'package:spaced_repetition_notes/app/extention/add_days_extention.dart';
import 'package:spaced_repetition_notes/app/extention/note_id_extention.dart';
import 'package:spaced_repetition_notes/features/home_page/view/widgets/note_add_and_remove_floating_button.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/note_cubit.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/note_cubit_state.dart';
import 'package:spaced_repetition_notes/service/modal/note_item.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NoteAddAndRemoveFloatingButtons(),
      body: BlocBuilder<NoteCubit, CubitBaseState>(
        builder: (BuildContext context, CubitBaseState state) {
          if (state is CubitSuccessState) {
            final currentTime = DateTime.now();
            return Stepper(
              stepIconBuilder: (stepIndex, stepState) {
                if (stepIndex == 6) {
                  return const Icon(Icons.visibility);
                } else {
                  const Icon(Icons.access_alarm_outlined);
                }
                return null;
              },
              onStepTapped: (value) =>
                  context.read<NoteCubit>().changeStep(value),
              currentStep: context.watch<NoteCubit>().currentStep,
              controlsBuilder: (context, details) => Container(
                width: MediaQuery.of(context).size.width,
              ),
              steps: [
                for (int dayLater = 6; dayLater > -1; dayLater--)
                  Step(
                    isActive: context.watch<NoteCubit>().currentStep ==
                        currentTime.add(Duration(days: dayLater)).weekday,
                    title: Row(
                      children: [
                        Text(
                          StringConstants.days[
                                  currentTime.addDays(dayLater).weekday] ??
                              'Error',
                          style: const TextStyleConstants.noteCaption(),
                        ),
                        const SizedBox(
                          width: DecorationConstants.titleIconSpace,
                        ),
                        for (final NoteItem iconItem in state
                                .allItems[
                                    currentTime.addDays(dayLater).toNoteId()]
                                ?.noteItemList
                                .cast<NoteItem>() ??
                            [])
                          Icon(
                            IconData(
                              iconItem.iconCode,
                              fontFamily: 'MaterialIcons',
                            ),
                          ),
                      ],
                    ),
                    content: const Text('data'),
                  ),
              ],
            );
          } else if (state is CubitErrorState) {
            return Center(
              child: LottieBuilder.asset('anim_hata.json'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
