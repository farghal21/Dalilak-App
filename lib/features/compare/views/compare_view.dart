import 'package:dalilak_app/core/helper/get_it.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/compare/manager/compare_cubit.dart';
import 'package:dalilak_app/features/compare/views/widgets/compare_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';

class CompareView extends StatelessWidget {
  const CompareView({super.key});

  static const routeName = 'CompareView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CompareCubit>()
        ..saveComparedCars(UserCubit.get(context).comparedCars),
      child: const CustomScaffold(
        isHomeScreen: true,
        drawerSelectedIndex: 2,
        body: CompareViewBody(),
      ),
    );
  }
}
