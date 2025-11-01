import 'package:firebase_core/firebase_core.dart';
import 'storage/shared_prefs_service.dart';
import '../firebase_options.dart';

class AppInitializer {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await SharedPrefsService.init();
  }
}
