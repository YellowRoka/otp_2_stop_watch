import 'package:flutter/material.dart';
import 'package:otp2/system/utils/app_constants.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.location,
    super.key,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.errorTitle),
      ),
      body: Center(
        child: Text('${AppConstants.pageNotFoundPrefix} $location'),
      ),
    );
  }
}
