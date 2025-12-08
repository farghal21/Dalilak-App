import 'package:dalilak_app/features/billing/views/widgets/billing_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import '../manager/billing_cubit/billing_cubit.dart';

class BillingView extends StatelessWidget {
  const BillingView({super.key});

  static const String routeName = 'billingView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillingCubit(),
      child: CustomScaffold(
        drawerSelectedIndex: 2,
        isHomeScreen: true,
        body: BillingViewBody(),
      ),
    );
  }
}
