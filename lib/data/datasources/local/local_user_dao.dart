import 'package:sqflite/sqflite.dart';

import '../../../core/storage/database_helper.dart';
import '../../models/user_model.dart';

class LocalUserDao {
  Future<void> insertUser(UserModel user) async {
    final db = await DatabaseHelper().getDb();
    await db.insert('users', user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<UserModel?> getUser(String id) async {
    final db = await DatabaseHelper().getDb();
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) return UserModel.fromJson(result.first);
    return null;
  }

  Future<void> deleteUser(String id) async {
    final db = await DatabaseHelper().getDb();
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
