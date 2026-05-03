import 'package:dalilak_app/core/user/data/repo/user_repo.dart';
import 'package:dalilak_app/core/user/data/repo/user_repo_impl.dart';
import 'package:dalilak_app/features/chat_history/data/repos/chat_history_repo.dart';
import 'package:dalilak_app/features/chat_history/data/repos/chat_history_repo_impl.dart';
import 'package:dalilak_app/features/compare/manager/compare_cubit.dart';
import 'package:dalilak_app/features/favorite/manager/favorite_cubit.dart';
import 'package:dalilak_app/features/used_cars/data/repo/used_cars_repo.dart';
import 'package:dalilak_app/features/used_cars/manager/used_cars_cubit/used_cars_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../network/api_helper.dart';
import '../network/end_points.dart';

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

  getIt.registerSingleton<ChatHistoryRepo>(
    ChatHistoryRepoImpl(apiHelper: getIt<ApiHelper>()),
  );

  // Used Cars - Repository and Cubit (simplified to match other features)
  getIt.registerLazySingleton<UsedCarsRepository>(
    () => UsedCarsRepository(
      dio: getIt<ApiHelper>().dio,
      baseUrl: EndPoints.baseUrl,
    ),
  );

  getIt.registerFactory<UsedCarsCubit>(
    () => UsedCarsCubit(getIt<UsedCarsRepository>()),
  );

  // إضافة CompareCubit كـ Singleton لتحسين الأداء
  getIt.registerLazySingleton<CompareCubit>(() => CompareCubit());

  // إضافة FavoriteCubit كـ Singleton لتحسين الأداء
  getIt.registerLazySingleton<FavoriteCubit>(() => FavoriteCubit());
}
