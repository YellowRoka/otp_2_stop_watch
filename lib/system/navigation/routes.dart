import 'package:go_router/go_router.dart';
import 'package:otp2/system/utils/app_constants.dart';
import 'package:otp2/ui/error_page/error_view.dart';
import 'package:otp2/ui/splash_page/splash_view.dart';
import 'package:otp2/ui/stop_watch_page/stopwatch_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.splashPath,
    routes: [

      GoRoute(
        path: AppConstants.splashPath,
        name: AppConstants.splashRouteName,
        builder: (context, state) => const SplashView(
          targetLocation: AppConstants.stopwatchPath,
        ),
      ),

      GoRoute(
        path: AppConstants.stopwatchPath,
        name: AppConstants.stopwatchRouteName,
        builder: (context, state) => const StopwatchView(),
      ),
      
    ],
    errorBuilder: (context, state) => ErrorView(
      location: state.matchedLocation,
    ),
  );
}
