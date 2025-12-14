import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';
import '../../manager/slider_cubit/slider_cubit.dart';

class CarDetailsSlider extends StatelessWidget {
  CarDetailsSlider({super.key});

  final List<String> sliderImages = [
    AppAssets.car1,
    AppAssets.car1,
    AppAssets.car1,
  ];

  @override
  Widget build(BuildContext context) {
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
      items: sliderImages.map((imagePath) {
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
    return Image.asset(
      imagePath,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
