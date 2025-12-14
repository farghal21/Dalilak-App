import 'package:dalilak_app/features/compare/views/widgets/spec_row.dart';
import 'package:dalilak_app/features/compare/views/widgets/spec_section.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: Center(child: Text("FavoriteViewBody" , style: AppTextStyles.bold20)),
    );
  }
}