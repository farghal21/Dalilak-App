import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../manager/slider_cubit/slider_cubit.dart';
import '../../manager/slider_cubit/slider_state.dart';
import 'car_details_slider.dart';

class CarDetailsStackSliderWidget extends StatelessWidget {
  const CarDetailsStackSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarDetailsSlider(),
        // Positioned(
        //   top: MyResponsive.height(value: 30),
        //   left: MyResponsive.width(value: 15),
        //   child: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     style: IconButton.styleFrom(
        //       shape: CircleBorder(),
        //       backgroundColor: AppColors.white.withValues(alpha: 0.4),
        //     ),
        //     icon: Icon(
        //       Icons.arrow_back_sharp,
        //       size: MyResponsive.fontSize(value: 25),
        //     ),
        //   ),
        // ),
        // Positioned(
        //   top: MyResponsive.height(value: 30),
        //   right: MyResponsive.width(value: 15),
        //   child: IconButton(
        //     onPressed: () {},
        //     style: IconButton.styleFrom(
        //       shape: CircleBorder(),
        //       backgroundColor: AppColors.white.withValues(alpha: 0.4),
        //     ),
        //     icon: Icon(
        //       Icons.favorite_border,
        //       size: MyResponsive.fontSize(value: 25),
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: MyResponsive.height(value: 15),
          left: MyResponsive.width(value: 170),
          // right: 0,
          child: BlocBuilder<SliderCubit, SliderState>(
            builder: (context, state) {
              return AnimatedSmoothIndicator(
                activeIndex: SliderCubit.get(context).currentIndex,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: MyResponsive.height(value: 10),
                  dotWidth: MyResponsive.width(value: 10),
                  activeDotColor: AppColors.white.withValues(alpha: .9),
                  dotColor: AppColors.white.withAlpha(51),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
