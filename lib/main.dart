
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_full_architecture/core/routes/app_router.dart';
import 'package:riverpod_full_architecture/core/routes/route_names.dart';
import 'package:riverpod_full_architecture/presentation/ui_constants/app_theme.dart';
import 'core/app_initializer.dart';
import 'presentation/features/auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await AppInitializer.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marine Jobs Portal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
     initialRoute: RouteNames.login,
      onGenerateRoute: AppRouter.generateRoute,

    );
  }
}
