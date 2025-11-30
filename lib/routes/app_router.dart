import 'package:flutter/material.dart';
import 'package:runner_sos/routes/app_routes.dart';
import 'package:runner_sos/ui/auth/email_verification_screen.dart';
import '../ui/auth/login_screen.dart';
import '../ui/auth/register_screen.dart';
import '../ui/runner/runner_homepage.dart';
import '../ui/staff/staff_homepage.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case AppRoutes.emailVerification:
        return MaterialPageRoute(
          builder: (_) => const EmailVerificationScreen(),
        );

      case AppRoutes.runnerDashboard:
        return MaterialPageRoute(builder: (_) => const RunnerHomepage());

      case AppRoutes.staffDashboard:
        return MaterialPageRoute(builder: (_) => const StaffHomepage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found!'))),
        );
    }
  }
}
