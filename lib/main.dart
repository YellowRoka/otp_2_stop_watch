import 'package:flutter/material.dart';
import 'package:otp2/di/injection.dart';
import 'package:otp2/system/navigation/routes.dart';
import 'package:otp2/system/theme/app_theme.dart';
import 'package:otp2/system/utils/app_constants.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appTitle,
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
