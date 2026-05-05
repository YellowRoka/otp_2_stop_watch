import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp2/di/injection.dart';
import 'package:otp2/system/utils/app_constants.dart';
import 'package:otp2/ui/stop_watch_page/bloc/state_enums/stop_watch_display_mode_enum.dart';
import 'package:otp2/ui/stop_watch_page/bloc/stopwatch_bloc.dart';
import 'package:otp2/ui/stop_watch_page/bloc/stopwatch_state.dart';
import 'package:otp2/ui/stop_watch_page/parts/analog_stopwatch_display.dart';
import 'package:otp2/ui/stop_watch_page/parts/digital_stopwatch_display.dart';
import 'package:otp2/ui/stop_watch_page/parts/display_mode_switch.dart';
import 'package:otp2/ui/stop_watch_page/parts/laps_list.dart';
import 'package:otp2/ui/stop_watch_page/parts/watch_control_buttons.dart';

class StopwatchView extends StatelessWidget {
  const StopwatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StopwatchBloc>(
      create: (context) => getIt<StopwatchBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppConstants.appTitle)),
        body: BlocBuilder<StopwatchBloc, StopwatchState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(AppConstants.pagePadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DisplayModeSwitch(displayMode: state.displayMode),

                  const SizedBox(height: AppConstants.pagePadding),

                  AnimatedSwitcher(
                    duration: AppConstants.displayModeSwitchDuration,
                    child: 
                      state.displayMode == StopwatchDisplayModeEnum.analog?
                      AnalogStopwatchDisplay(elapsedTime: state.snapshot.elapsedTime):
                      DigitalStopwatchDisplay(elapsedTime: state.snapshot.elapsedTime),
                  ),

                  const SizedBox(height: AppConstants.sectionSpacing),

                  const WatchControlButtons(),

                  const SizedBox(height: AppConstants.sectionSpacing),

                  LapsList(laps: state.snapshot.laps),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
