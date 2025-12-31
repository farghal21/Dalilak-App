import 'package:dalilak_app/core/shared_widgets/custom_scaffold.dart';
import 'package:dalilak_app/features/add_car/manager/add_car_cubit.dart';
import 'package:dalilak_app/features/add_car/views/widgets/add_car_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';

class AddCarView extends StatelessWidget {
  const AddCarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCarCubit(),
      child: CustomScaffold(
        drawerSelectedIndex: 7,
        isHomeScreen: true,
        appBar: AppBar(
          title: Text(
            AppStrings.sellYourCar,
            style: AppTextStyles.semiBold20.copyWith(color: AppColors.white),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: AppColors.horizontalGradient,
            ),
          ),
          iconTheme: IconThemeData(color: AppColors.white),
        ),
        body: const AddCarViewBody(),
      ),
    );
  }
}
