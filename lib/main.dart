import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:runner_sos/ui/auth/email_verification_screen.dart';
import 'package:runner_sos/ui/auth/login_screen.dart';
import 'package:runner_sos/ui/auth/register_screen.dart';
import 'package:runner_sos/ui/runner/runner_dashboard.dart';
import 'package:runner_sos/ui/staff/staff_dashboard.dart';
import 'package:runner_sos/viewmodels/profile_provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'viewmodels/auth_provider.dart';
import 'routes/app_router.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.login,
        routes: {
          AppRoutes.login: (context) => const LoginScreen(),
          AppRoutes.register: (context) => const RegisterScreen(),
          AppRoutes.emailVerification: (context) =>
              const EmailVerificationScreen(), // NEW
          AppRoutes.runnerDashboard: (context) => const RunnerDashboard(),
          AppRoutes.staffDashboard: (context) => const StaffDashboard(),
        },
      ),
    );
  }
}
