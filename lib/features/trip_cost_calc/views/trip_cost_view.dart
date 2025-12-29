import 'package:dalilak_app/core/shared_widgets/custom_scaffold.dart';
import 'package:dalilak_app/features/trip_cost_calc/manager/trip_cost_cubit.dart';
import 'package:dalilak_app/features/trip_cost_calc/views/widgets/trip_cost_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripCostView extends StatelessWidget {
  static const String routeName = 'trip_cost_view';

  // نستقبل الاستهلاك الابتدائي لو جايين من صفحة عربية
  final double? initialConsumption;

  const TripCostView({super.key, this.initialConsumption});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TripCostCubit(
        initialConsumption: initialConsumption?.toString(),
      ),
      child: const CustomScaffold(
        isHomeScreen: true,
        drawerSelectedIndex: 5,
        body: TripCostViewBody(),
      ),
    );
  }
}
