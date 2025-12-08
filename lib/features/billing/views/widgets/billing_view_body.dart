import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../history/views/widgets/history_app_bar.dart';
import '../../manager/billing_cubit/billing_cubit.dart';
import '../../manager/billing_cubit/billing_state.dart';
import 'billing_details_list_view.dart';
import 'filter_row_widget.dart';

class BillingViewBody extends StatelessWidget {
  const BillingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BillingCubit, BillingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BillingCubit.get(context);
        return Padding(
          padding: MyResponsive.paddingSymmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: MyResponsive.height(value: 100),
              ),

              HistoryAppBar(),

              SizedBox(
                height: MyResponsive.height(value: 34),
              ),

              CustomTextFormField(
                type: TextFieldType.search,
                searchOnChange: (value) {
                  cubit.searchInBilling(value);
                },
              ),

              // لو عايز ترجع الفلتر فعل السطر ده
              // SizedBox(height: MyResponsive.height(value: 20)),
              // FilterRowWidget(),

              SizedBox(height: MyResponsive.height(value: 20)),

              /// 👇 أهم تعديل هنا: Expanded + Scroll للجزء اللي تحت بس
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      BillingDetailsListView(),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: MyResponsive.height(value: 40),
              ),
            ],
          ),
        );
      },
    );
  }
}
