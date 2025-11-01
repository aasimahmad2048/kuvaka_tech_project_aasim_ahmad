
import '../entities/user_entity.dart';

abstract class LocalStorageRepository {
  Future<void> saveUser(UserEntity user);
  Future<UserEntity?> getUser(String id);
  Future<void> deleteUser(String id);
}
