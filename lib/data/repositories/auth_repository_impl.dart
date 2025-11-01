import 'package:riverpod_full_architecture/data/datasources/remote/api_auth_service.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase/firebase_auth_service.dart';
import '../datasources/local/local_auth_service.dart';
import '../models/user_model.dart';

enum DataSourceType { firebase, api, local }

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService firebaseAuthService;
  final ApiAuthService apiAuthService;
  final LocalAuthService localAuthService;
  final DataSourceType sourceType;

  AuthRepositoryImpl({
    required this.firebaseAuthService,
    required this.apiAuthService,
    required this.localAuthService,
    this.sourceType = DataSourceType.firebase,
  });

  @override
  Future<UserEntity> login(String email, String password) async {
    if (sourceType == DataSourceType.local) {
      final model = await localAuthService.login(email, password);
      return model.toEntity();
    } else if (sourceType == DataSourceType.firebase) {
      final user = await firebaseAuthService.loginWithEmail(email, password);
      if (user == null) {
        throw Exception('Login failed: User is null');
      }
      final model = UserModel(id: user.uid, email: user.email ?? '');
      return model.toEntity();
    } else {
      final json = await apiAuthService.login(email, password);
      final model = UserModel.fromJson(json);
      return model.toEntity();
    }
  }

  @override
  Future<UserEntity> register(
      String email, String password, String name) async {
    if (sourceType == DataSourceType.local) {
      final model = await localAuthService.register(email, password, name);
      print(model.toString());
      print("user registerred");
      return model.toEntity();
    } else if (sourceType == DataSourceType.firebase) {
      final user = await firebaseAuthService.registerWithEmail(email, password);
      if (user == null) {
        throw Exception('Registration failed: User is null');
      }
      final model = UserModel(id: user.uid, email: user.email ?? '');

      return model.toEntity();
    } else {
      final json = await apiAuthService.register(email, password, name);

      final model = UserModel.fromJson(json);
      return model.toEntity();
    }
  }

  @override
  Future<void> logout() async {
    if (sourceType == DataSourceType.firebase) {
      await firebaseAuthService.logout();
    } else {
      await apiAuthService.logout();
    }
  }
}
