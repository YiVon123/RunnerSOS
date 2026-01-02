import 'package:flutter/material.dart';
import 'package:runner_sos/routes/app_routes.dart';
import 'package:runner_sos/ui/auth/email_verification_screen.dart';
import 'package:runner_sos/ui/medic/medic_shell.dart';
import 'package:runner_sos/ui/runner/runner_shell.dart';
import 'package:runner_sos/ui/staff/staff_shell.dart';
import '../ui/auth/login_screen.dart';
import '../ui/auth/register_screen.dart';

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

      case AppRoutes.runnerHomepage:
        return MaterialPageRoute(builder: (_) => const RunnerShell());

      case AppRoutes.staffHomepage:
        return MaterialPageRoute(builder: (_) => const StaffShell());

      case AppRoutes.medicHomepage:
        return MaterialPageRoute(builder: (_) => const MedicShell());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found!'))),
        );
    }
  }
}
