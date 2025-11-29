import 'package:flutter/material.dart';
import 'package:runner_sos/routes/app_routes.dart';
import '../ui/auth/login_screen.dart';
import '../ui/auth/register_screen.dart';
import '../ui/runner/runner_dashboard.dart';
import '../ui/staff/staff_dashboard.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case AppRoutes.runnerDashboard:
        return MaterialPageRoute(builder: (_) => const RunnerDashboard());

      case AppRoutes.staffDashboard:
        return MaterialPageRoute(builder: (_) => const StaffDashboard());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found!'))),
        );
    }
  }
}
