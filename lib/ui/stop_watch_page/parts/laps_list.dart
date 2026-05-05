import 'package:flutter/material.dart';
import 'package:otp2/business/utils/duration_ext.dart';
import 'package:otp2/system/utils/app_constants.dart';

class LapsList extends StatelessWidget {
  final List<Duration> laps;

  const LapsList({super.key, required this.laps});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: laps.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              '${AppConstants.lapListPrefix} '
              '${index + AppConstants.listDisplayIndexOffset}: '
              '${laps[index].toDurationDisplay()}',
            ),
          );
        },
      ),
    );
  }
}
