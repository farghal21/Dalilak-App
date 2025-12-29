import 'package:dalilak_app/features/trip_cost_calc/view/trip_cost_view_body.dart';
import 'package:flutter/material.dart';
import '../../../../core/shared_widgets/custom_scaffold.dart';

class TripCostView extends StatelessWidget {
  static const String routeName = 'trip_cost_view';

  // نستقبل الاستهلاك الابتدائي لو جايين من صفحة عربية
  final double? initialConsumption;

  const TripCostView({super.key, this.initialConsumption});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHomeScreen: true,
      drawerSelectedIndex: 5,
      body: TripCostViewBody(initialConsumption: initialConsumption),
    );
  }
}
