import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';

import '../../manager/slider_cubit/slider_cubit.dart';

class CarDetailsSlider extends StatelessWidget {
  const CarDetailsSlider({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return CarouselSlider(
      options: CarouselOptions(
        height: MyResponsive.height(value: 400),
        autoPlay: true,
        viewportFraction: 1,
        enableInfiniteScroll: true,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {
          SliderCubit.get(context).changeSliderIndex(index);
        },
      ),
      items: cubit.selectedCar!.images.map((imagePath) {
        return SliderWidget(
          imagePath: imagePath,
        );
      }).toList(),
    );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImageWrapper(
      imagePath: imagePath,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );
  }
}
