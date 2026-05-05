import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp2/system/utils/app_constants.dart';
import 'package:otp2/ui/stop_watch_page/bloc/stopwatch_bloc.dart';
import 'package:otp2/ui/stop_watch_page/bloc/stopwatch_event.dart';
import 'package:otp2/ui/stop_watch_page/parts/stopper_button.dart';

class WatchControlButtons extends StatelessWidget {
  const WatchControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        StopperButton(
          title: AppConstants.startButtonLabel,
          onPressed: () => context.read<StopwatchBloc>().add(const StopwatchEvent.start()),
        ),

        StopperButton(
          title: AppConstants.pauseButtonLabel,
          onPressed: () => context.read<StopwatchBloc>().add(const StopwatchEvent.pause()),
        ),

        StopperButton(
          title: AppConstants.resetButtonLabel,
          onPressed: () => context.read<StopwatchBloc>().add(const StopwatchEvent.reset()),
        ),

        StopperButton(
          title: AppConstants.lapButtonLabel,
          onPressed: () => context.read<StopwatchBloc>().add(const StopwatchEvent.recordLap()),
        ),
        
      ],
    );
  }
}
