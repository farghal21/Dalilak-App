import 'package:dalilak_app/features/compare/views/widgets/compare_view_body.dart';
import 'package:dalilak_app/features/favorite/view/widget/favorite_view_body.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  static const String routeName = 'FavoriteView';


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHomeScreen: true,
      drawerSelectedIndex: 3,
      body: FavoriteViewBody(),
    );
  }
}
