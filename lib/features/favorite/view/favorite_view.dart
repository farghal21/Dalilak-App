import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/favorite/manager/favorite_cubit.dart';
import 'package:dalilak_app/features/favorite/view/widget/favorite_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  static const String routeName = 'FavoriteView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoriteCubit()..init(UserCubit.get(context).favoriteCars),
      child: CustomScaffold(
        isHomeScreen: true,
        drawerSelectedIndex: 3,
        body: FavoriteViewBody(),
      ),
    );
  }
}
