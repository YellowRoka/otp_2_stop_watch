import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp2/system/utils/app_constants.dart';
import 'package:otp2/ui/stop_watch_page/bloc/stopwatch_bloc.dart';
import 'package:otp2/ui/stop_watch_page/bloc/stopwatch_event.dart';
import 'package:otp2/ui/stop_watch_page/bloc/state_enums/stop_watch_display_mode_enum.dart';

class DisplayModeSwitch extends StatelessWidget {
  const DisplayModeSwitch({
    required this.displayMode,
    super.key,
  });

  final StopwatchDisplayModeEnum displayMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          AppConstants.digitalDisplayLabel,
          style: Theme.of(context).textTheme.labelLarge,
        ),

        Switch(
          value: displayMode == StopwatchDisplayModeEnum.analog,
          onChanged: (value) {
            context.read<StopwatchBloc>().add(
              StopwatchEvent.displayModeChanged(
                value ? StopwatchDisplayModeEnum.analog : StopwatchDisplayModeEnum.digital,
              ),
            );
          },
        ),

        Text(
          AppConstants.analogDisplayLabel,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
