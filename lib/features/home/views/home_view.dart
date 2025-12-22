import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/home/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/get_it.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../data/repo/home_repo.dart';
import '../manager/home_cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.sessionId});

  static const String routeName = "home";
  final String? sessionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        getIt<HomeRepo>(),
        userId: UserCubit.get(context).userModel.id!,
        sessionId: sessionId,
      ),
      child: const CustomScaffold(
        isHomeScreen: true,
        drawerSelectedIndex: 0,
        body: HomeViewBody(),
      ),
    );
  }
}
