import 'package:dalilak_app/core/helper/get_it.dart';
import 'package:dalilak_app/core/shared_widgets/custom_scaffold.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/home/data/repo/home_repo.dart';
import 'package:dalilak_app/features/home/manager/home_cubit/home_cubit.dart';
import 'package:dalilak_app/features/home/views/widgets/home_view_body.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.sessionId});

  static const String routeName = "home";
  final String? sessionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        getIt<HomeRepo>(),
        // 👇 التعديل هنا: شيلنا علامة التعجب (!) وحطينا قيمة افتراضية (0)
        userId: UserCubit.get(context).userModel.id ?? 0,
        sessionId: sessionId,
      )..init(),
      child: const CustomScaffold(
        isHomeScreen: true,
        drawerSelectedIndex: 0,
        body: HomeViewBody(),
      ),
    );
  }
}
