import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_full_architecture/core/core_constants/app_config.dart';
import '../data/datasources/firebase/firebase_auth_service.dart';
import '../data/datasources/local/local_auth_service.dart';
import '../data/datasources/remote/api_auth_service.dart';
import '../data/datasources/local/local_user_dao.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/local_storage_repository_impl.dart';

/// Determines the data source based on the environment configuration.
final dataSourceTypeProvider = Provider<DataSourceType>((ref) {
  if (AppConfig.useFirebase) {
    return DataSourceType.firebase;
  } else if (AppConfig.useLocalDatabase) {
    return DataSourceType.local;
  } else {
    return DataSourceType.api;
  }
});

final firebaseAuthServiceProvider = Provider((ref) => FirebaseAuthService());
final apiAuthServiceProvider = Provider((ref) => ApiAuthService());
final localUserDaoProvider = Provider((ref) => LocalUserDao());

// Define the dependency first.
final localStorageRepositoryProvider = Provider(
  (ref) => LocalStorageRepositoryImpl(ref.read(localUserDaoProvider)),
);

// Now, the provider that depends on it can be defined.
final localAuthServiceProvider = Provider<LocalAuthService>(
  (ref) => LocalAuthServiceImpl(ref.read(localUserDaoProvider)),
);

final authRepositoryProvider = Provider((ref) {
  final type = ref.read(dataSourceTypeProvider);
  return AuthRepositoryImpl(
    firebaseAuthService: ref.read(firebaseAuthServiceProvider),
    apiAuthService: ref.read(apiAuthServiceProvider),
    localAuthService: ref.read(localAuthServiceProvider),
    sourceType: type,
  );
});
