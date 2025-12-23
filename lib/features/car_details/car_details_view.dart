import 'package:dalilak_app/features/car_details/manager/slider_cubit/slider_cubit.dart';
import 'package:dalilak_app/features/car_details/view/place_details_widgets/car_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';

class CarDetailsView extends StatelessWidget {
  const CarDetailsView({super.key});

  static const String routeName = 'CarDetails';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SliderCubit(),
      child: CustomScaffold(
        isHomeScreen: false,
        showDrawer: false,
        body: CarDetailsViewBody(),
      ),
    );
  }
}
