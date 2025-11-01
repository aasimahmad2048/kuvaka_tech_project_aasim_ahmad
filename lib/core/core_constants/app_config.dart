import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A centralized configuration class to access environment variables.
/// This helps in decoupling the rest of the app from the dotenv package.
class AppConfig {
  // General App Config
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static bool get isDebugMode => dotenv.env['DEBUG_MODE'] == 'true';

  /// Determines if the app should use Firebase for authentication.
  static bool get useFirebase => dotenv.env['USE_FIREBASE'] == 'true';

  /// Determines if the app should use a local database for caching.
  static bool get useLocalDatabase =>
      dotenv.env['USE_LOCAL_DATABASE'] == 'true';

  /// Determines if the app should use a local database for caching.
  static bool get useLocalStorage => dotenv.env['USE_LOCAL_STORAGE'] == 'true';
  static bool get useSecureStorage =>
      dotenv.env['USE_SECURE_STORAGE'] == 'true';

  // Common Firebase Config
  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  static String get firebaseMessagingSenderId =>
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  static String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';

  // Android Firebase Config
  static String get firebaseAndroidApiKey =>
      dotenv.env['FIREBASE_ANDROID_API_KEY'] ?? '';
  static String get firebaseAndroidAppId =>
      dotenv.env['FIREBASE_ANDROID_APP_ID'] ?? '';

  // iOS & macOS Firebase Config
  static String get firebaseIosApiKey =>
      dotenv.env['FIREBASE_IOS_API_KEY'] ?? '';
  static String get firebaseIosAppId => dotenv.env['FIREBASE_IOS_APP_ID'] ?? '';
  static String get firebaseIosBundleId =>
      dotenv.env['FIREBASE_IOS_BUNDLE_ID'] ?? '';

  // Web & Windows Firebase Config
  static String get firebaseWebApiKey =>
      dotenv.env['FIREBASE_WEB_API_KEY'] ?? '';
  static String get firebaseWebAppId => dotenv.env['FIREBASE_WEB_APP_ID'] ?? '';
  static String get firebaseWebAuthDomain =>
      dotenv.env['FIREBASE_WEB_AUTH_DOMAIN'] ?? '';
  static String get firebaseWebMeasurementId =>
      dotenv.env['FIREBASE_WEB_MEASUREMENT_ID'] ?? '';
  static String get firebaseWindowsAppId =>
      dotenv.env['FIREBASE_WINDOWS_APP_ID'] ?? '';
  static String get firebaseWindowsAuthDomain =>
      dotenv.env['FIREBASE_WINDOWS_AUTH_DOMAIN'] ?? '';
  static String get firebaseWindowsMeasurementId =>
      dotenv.env['FIREBASE_WINDOWS_MEASUREMENT_ID'] ?? '';
}
