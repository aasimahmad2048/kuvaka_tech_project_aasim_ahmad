import 'package:riverpod_full_architecture/domain/entities/user_entity.dart';
import 'package:riverpod_full_architecture/data/datasources/local/local_user_dao.dart';

import '../../models/user_model.dart';

/// A contract for local authentication services (e.g., using sqflite).
abstract class LocalAuthService {
  Future<UserModel> register(String email, String password, String name);
  Future<UserModel> login(String email, String password);
}

/// A concrete implementation of LocalAuthService using a local database.
/// For now, this is a placeholder. You would add your sqflite logic here.
class LocalAuthServiceImpl implements LocalAuthService {
  final LocalUserDao _localUserDao;
  LocalAuthServiceImpl(this._localUserDao);

  @override
  Future<UserModel> login(String email, String password) async {
    print('Logging in user locally: $email');
    // The user ID is the email in the local implementation
    final userModel = await _localUserDao.getUser(email);
    if (userModel != null && userModel.email == email) {
      // In a real app, you would also verify the password here.
      return userModel;
    }
    print('Invalid local credentials');
    throw Exception('User not found or invalid credentials');
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    print('Registering user locally: $email');

    // Using email as the unique ID for the local database user.
    final user = UserModel(id: email, email: email, name: name);

    await _localUserDao.insertUser(user);

    print('User registered locally: $email');

    // Return the user model that was just saved.
    return user;
  }
}
