
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';

import 'first_section_details.dart';
import 'car_details_stack_slider_widget.dart';
import 'second_section_features.dart';

class CarDetailsViewBody extends StatelessWidget {
  const CarDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarDetailsStackSliderWidget(),
          SizedBox(height: MyResponsive.height(value: 20)),
          FirstSectionDetails(),
          SizedBox(
            height: MyResponsive.height(value: 40),
          ),
          SecondSectionFeatures(),
          SizedBox(
            height: MyResponsive.height(value: 20),
          ),

          SizedBox(
            height: MyResponsive.height(value: 40),
          ),
        ],
      ),
    );
  }
}
