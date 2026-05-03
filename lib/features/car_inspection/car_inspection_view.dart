import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/shared_widgets/custom_scaffold.dart';
import 'manager/car_inspection_cubit.dart';
import 'views/car_inspection_view_body.dart';

class CarInspectionView extends StatelessWidget {
  static const String routeName = 'car_inspection_view';

  const CarInspectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarInspectionCubit(),
      child: const CustomScaffold(
        isHomeScreen: true,
        drawerSelectedIndex: 6,
        body: CarInspectionViewBody(),
      ),
    );
  }
}
