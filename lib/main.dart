import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:runner_sos/utils/app_themes.dart';
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
        theme: AppThemes.light,
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
