import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:otp2/system/utils/app_constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({
    required this.targetLocation,
    super.key,
  });

  final String targetLocation;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(AppConstants.splashDelay, () {
      if (mounted) {
        context.go(widget.targetLocation);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Icon(
              Icons.timer_outlined,
              size: AppConstants.splashIconSize,
            ),

            SizedBox(height: AppConstants.sectionSpacing),

            Text(
              AppConstants.appTitle,
              style: TextStyle(
                fontSize: AppConstants.splashTitleFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: AppConstants.sectionSpacing),

            CircularProgressIndicator(),

          ],
        ),
      ),
    );
  }
}
