import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_full_architecture/presentation/features/auth/login_controller.dart';
import 'package:riverpod_full_architecture/presentation/widgets/app_button.dart';
import 'package:riverpod_full_architecture/presentation/widgets/app_scaffold.dart';
import 'package:riverpod_full_architecture/presentation/widgets/app_textformfield.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Register",
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              AppTextFormField(
                controller: nameCtrl,
                hint: "Full Name",
                icon: Icons.person,
              ),
              const SizedBox(height: 12),
              AppTextFormField(
                controller: emailCtrl,
                hint: "Email",
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              const SizedBox(height: 12),
              AppTextFormField(
                controller: passCtrl,
                hint: "Password",
                obscureText: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 24),
              AppButton(
                text: "Register",
                isLoading: _isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _isLoading = true);
                    try {
                      final user = await ref
                          .read(loginControllerProvider.notifier)
                          .register(
                            emailCtrl.text.trim(),
                            passCtrl.text.trim(),
                            nameCtrl.text.trim(),
                          );
                      if (mounted) {
                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Registration successful!")),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Registration failed.")),
                          );
                        }
                      }
                    } finally {
                      if (mounted) {
                        setState(() => _isLoading = false);
                      }
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to login
                },
                child: const Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
