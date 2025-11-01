
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/local_storage_repository.dart';
import '../datasources/local/local_user_dao.dart';
import '../models/user_model.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final LocalUserDao localUserDao;

  LocalStorageRepositoryImpl(this.localUserDao);

  @override
  Future<void> saveUser(UserEntity user) async {
    final model = UserModel(id: user.id, email: user.email, name: user.name);
    await localUserDao.insertUser(model);
  }

  @override
  Future<UserEntity?> getUser(String id) async {
    final model = await localUserDao.getUser(id);
    return model?.toEntity();
  }

  @override
  Future<void> deleteUser(String id) async {
    await localUserDao.deleteUser(id);
  }
}
