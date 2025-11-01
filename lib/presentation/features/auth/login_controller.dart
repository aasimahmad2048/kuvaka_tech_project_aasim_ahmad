import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_full_architecture/domain/usecases/login_user.dart';
import 'package:riverpod_full_architecture/domain/usecases/logout_user.dart';
import 'package:riverpod_full_architecture/domain/usecases/register_user.dart';
import 'package:riverpod_full_architecture/providers/usecase_providers.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/repositories/local_storage_repository.dart';
import '../../../providers/repository_providers.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue<UserEntity?>>(
  (ref) => LoginController(
    loginUser: ref.read(loginUserProvider),
    registerUser: ref.read(registerUserProvider),
    logoutUser: ref.read(logoutUserProvider),
    localStorageRepository: ref.read(localStorageRepositoryProvider),
    ref: ref,
  ),
);

class LoginController extends StateNotifier<AsyncValue<UserEntity?>> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final LogoutUser logoutUser;
  final LocalStorageRepository localStorageRepository;
  final Ref _ref;

  LoginController({
    required this.loginUser,
    required this.registerUser,
    required this.logoutUser,
    required this.localStorageRepository,
    required Ref ref,
  })  : _ref = ref,
        super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      // Downcast to access sourceType, not ideal but works for this fix.
      final authRepo = _ref.read(authRepositoryProvider);
      final user = await loginUser(email, password);
      if (authRepo.sourceType != DataSourceType.local) {
        await localStorageRepository.saveUser(user);
      }
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadLocalUser(String id) async {
    final user = await localStorageRepository.getUser(id);
    state = AsyncValue.data(user);
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await logoutUser();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<UserEntity?> register(
      String email, String password, String name) async {
    try {
      final user = await registerUser(email, password, name);
      await localStorageRepository.saveUser(user);
      return user;
    } catch (e, st) {
      return null;
    }
  }
}
