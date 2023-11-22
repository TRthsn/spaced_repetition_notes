import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:spaced_repetition_notes/app/constants/constants_decoration.dart';
import 'package:spaced_repetition_notes/app/constants/constants_string.dart';
import 'package:spaced_repetition_notes/app/constants/constants_text_style.dart';
import 'package:spaced_repetition_notes/app/extention/add_days_extention.dart';
import 'package:spaced_repetition_notes/app/extention/note_id_extention.dart';
import 'package:spaced_repetition_notes/features/home_page/view/widgets/note_add_and_remove_floating_button.dart';
import 'package:spaced_repetition_notes/features/home_page/view/widgets/theme_change_button.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/note_cubit.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/note_cubit_state.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/theme_cubit.dart';
import 'package:spaced_repetition_notes/service/modal/note_item.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late final TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          ThemeChangeButton(),
        ],
      ),
      floatingActionButton: NoteAddAndRemoveFloatingButtons(
        textEditingController: _textEditingController,
      ),
      body: BlocBuilder<NoteCubit, CubitBaseState>(
        builder: (BuildContext context, CubitBaseState state) {
          if (state is CubitSuccessState) {
            final currentTime = DateTime.now();
            return Stepper(
              stepIconBuilder: (stepIndex, stepState) {
                if (stepIndex == 6) {
                  return const Icon(Icons.visibility);
                } else {
                  return const Icon(Icons.access_alarm_outlined);
                }
              },
              //
              onStepTapped: (value) {
                final cubit = context.read<NoteCubit>();

                ///We get the day we click
                cubit.cacheManager.currentNoteTime =
                    DateTime.now().add(Duration(days: 6 - value));
                //We set the Stepper currentStep
                cubit.changeStep(value);
              },
              currentStep: context.watch<NoteCubit>().currentStep,
              controlsBuilder: (context, details) => Container(
                width: MediaQuery.of(context).size.width,
              ),
              steps: StepperSteps(context, currentTime, state),
            );
          } else if (state is CubitErrorState) {
            return Center(
              child: LottieBuilder.asset('assets/anim_hata.json'),
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

  List<Step> StepperSteps(
    BuildContext context,
    DateTime currentTime,
    CubitSuccessState state,
  ) {
    return [
      ///we write the days of the week upside down
      for (int dayLater = 6; dayLater > -1; dayLater--)
        Step(
          isActive: context.watch<NoteCubit>().currentStep ==
              context.read<NoteCubit>().getIndex(),
          title:
              stepTitleWeekDayAndIcons(currentTime, dayLater, state, context),
          content: MessageContainers(state, currentTime, dayLater, context),
        ),
    ];
  }

  Column MessageContainers(
    CubitSuccessState state,
    DateTime currentTime,
    int dayLater,
    BuildContext context,
  ) {
    return Column(
      children: [
        ///we print message containers
        for (final NoteItem messageItem in state
                .allItems[currentTime.addDays(dayLater).toNoteId()]
                ?.noteItemList
                .cast<NoteItem>() ??
            [])
          Dismissible(
            key: GlobalKey(),
            onDismissed: (direction) {
              context.read<NoteCubit>().removeItems(messageItem);
            },
            child: Padding(
              padding: DecorationConstants.noteContainerPadding,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: DecorationConstants.noteContainerColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: DecorationConstants.noteContainerItemPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${messageItem.time.year}-${messageItem.time.month}-${messageItem.time.day}',
                            style: const TextStyleConstants.noteDateAndHour(),
                          ),
                          Text(
                            '${messageItem.time.hour}:${messageItem.time.minute}',
                            style: const TextStyleConstants.noteDateAndHour(),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: DecorationConstants.dividerColor,
                    ),
                    Padding(
                      padding: DecorationConstants.noteContainerMessagePadding,
                      child: Text(
                        messageItem.message,
                        style: const TextStyleConstants.noteText(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  FittedBox stepTitleWeekDayAndIcons(
    DateTime currentTime,
    int dayLater,
    CubitSuccessState state,
    BuildContext context,
  ) {
    return FittedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ///title varies according to theme
              if (context.watch<ThemeCubit>().state == ThemeMode.light)
                Text(
                  StringConstants.days[currentTime.addDays(dayLater).weekday] ??
                      'Error',
                  style: dayLater == 0
                      ? const TextStyleConstants.noteCaptionCurrentDay()
                      : const TextStyleConstants.noteCaption(),
                )
              else
                Text(
                  StringConstants.days[currentTime.addDays(dayLater).weekday] ??
                      'Error',
                  style: dayLater == 0
                      ? const TextStyleConstants.noteCaptionCurrentDay()
                      : const TextStyleConstants.noteCaptionDarkMode(),
                ),
              Text(
                '  ${currentTime.addDays(dayLater).year}-${currentTime.addDays(dayLater).month}-${currentTime.addDays(dayLater).day}',
              ),
              const SizedBox(
                width: DecorationConstants.titleIconSpace,
              ),
            ],
          ),
          Row(
            children: [
              for (final NoteItem iconItem in state
                      .allItems[currentTime.addDays(dayLater).toNoteId()]
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
        ],
      ),
    );
  }
}
