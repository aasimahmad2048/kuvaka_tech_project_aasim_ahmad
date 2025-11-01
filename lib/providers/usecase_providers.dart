import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_full_architecture/domain/usecases/login_user.dart';
import 'package:riverpod_full_architecture/domain/usecases/logout_user.dart';
import 'package:riverpod_full_architecture/domain/usecases/register_user.dart';
import 'package:riverpod_full_architecture/providers/repository_providers.dart';

final loginUserProvider = Provider<LoginUser>(
  (ref) => LoginUser(ref.read(authRepositoryProvider)),
);

final registerUserProvider = Provider<RegisterUser>(
  (ref) => RegisterUser(ref.read(authRepositoryProvider)),
);

final logoutUserProvider = Provider<LogoutUser>(
  (ref) => LogoutUser(ref.read(authRepositoryProvider)),
);
