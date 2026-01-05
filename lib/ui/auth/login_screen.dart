import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_sos/routes/app_routes.dart';
import 'package:runner_sos/utils/validators.dart';
import '../../viewmodels/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email controller
              TextFormField(
                controller: _emailCtrl,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  errorMaxLines: 3,
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                enabled: !auth.isLoading,
                validator: (value) {
                  if (!Validators.isEmailValid(value!)) {
                    return "Invalid email. The standard format of email is name@domain.com. Please enter a valid email address.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Password controller
              TextFormField(
                controller: _passwordCtrl,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  errorMaxLines: 3,
                ),
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                enabled: !auth.isLoading,
                validator: (value) {
                  if (!Validators.isLoginPasswordValid(value!)) {
                    return "Invalid password. Password must be 8–16 characters long. Please enter a valid password.";
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  if (_formKey.currentState!.validate()) {
                    _handleLogin(context, auth);
                  }
                },
              ),

              const SizedBox(height: 16),

              // Error message
              if (auth.errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          auth.errorMessage!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              if (auth.errorMessage != null) const SizedBox(height: 16),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: auth.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            _handleLogin(context, auth);
                          }
                        },
                  child: auth.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text("Login", style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),

              // Register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: auth.isLoading
                        ? null
                        : () {
                            auth.clearError();
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.register,
                            );
                          },
                    child: const Text("Register"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context, AuthProvider auth) async {
    // Clear previous error
    auth.clearError();

    // Attempt login
    final success = await auth.login(
      _emailCtrl.text.trim(),
      _passwordCtrl.text,
    );

    if (success && mounted) {
      // Check if email is verified
      if (auth.currentUser?.emailVerified == false) {
        // Navigate to verification screen
        Navigator.pushReplacementNamed(context, AppRoutes.emailVerification);
      } else if (auth.currentUser?.status == 'active') {
        // Navigate to dashboard only if active and verified
        Navigator.pushReplacementNamed(context, auth.getHomeRoute());
      } else if (auth.currentUser?.status == 'inactive') {
        // Account not yet activated
        Navigator.pushReplacementNamed(context, AppRoutes.emailVerification);
      } else if (auth.currentUser?.status == 'suspended') {
        // Already handled in AuthProvider
        await auth.logout();
      }
    }
  }
}
