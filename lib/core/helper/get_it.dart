import 'package:dalilak_app/core/user/data/repo/user_repo.dart';
import 'package:dalilak_app/core/user/data/repo/user_repo_impl.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../network/api_helper.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ApiHelper>(ApiHelper());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(apiHelper: getIt<ApiHelper>()),
  );

  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(getIt<ApiHelper>()),
  );

  getIt.registerSingleton<UserRepo>(
    UserRepoImpl(apiHelper: getIt<ApiHelper>()),
  );
}
