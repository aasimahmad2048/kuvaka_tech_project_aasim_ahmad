import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_full_architecture/core/routes/route_names.dart';
import 'package:riverpod_full_architecture/presentation/features/auth/login_controller.dart';
import 'package:riverpod_full_architecture/presentation/widgets/app_textformfield.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_scaffold.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);

    ref.listen(loginControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (e, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login failed: $e")),
          );
        },
        data: (user) {
          if (user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login successful!")),
            );
            // Navigate to home (if exists)
            // Navigator.pushReplacementNamed(context, RouteNames.home);
          }
        },
      );
    });

    return AppScaffold(
      title: "Login",
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            AppTextFormField(
              controller: emailCtrl,
              hint: "Email",
              keyboardType: TextInputType.emailAddress,
              icon: Icons.email,
            ),
            AppTextFormField(
              controller: passCtrl,
              hint: "Password",
              obscureText: true,
              icon: Icons.lock,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: "Login",
              isLoading: loginState.isLoading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref
                      .read(loginControllerProvider.notifier)
                      .login(emailCtrl.text.trim(), passCtrl.text.trim());
                }
              },
            ),
            const SizedBox(height: 16),
            AppButton(
              text: "Register",
              isOutlined: true,
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.register);
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension AsyncValueX<T> on AsyncValue<T> {
  bool get isLoading => this is AsyncLoading;
}
