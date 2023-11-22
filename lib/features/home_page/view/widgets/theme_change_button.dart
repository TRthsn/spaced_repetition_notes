import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:spaced_repetition_notes/features/home_page/view_modal/theme_cubit.dart';

class ThemeChangeButton extends StatelessWidget {
  const ThemeChangeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Switch(
        value:
            context.watch<ThemeCubit>().state == ThemeMode.light ? true : false,
        onChanged: (value) {
          context.read<ThemeCubit>().changeTheme();
        },
      ),
    );
  }
}
