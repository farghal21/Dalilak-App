import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CarItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String price;

  const CarItemWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              height: MyResponsive.height(value: 80),
              fit: BoxFit.contain,
            ),
          ),
           SizedBox(height: MyResponsive.height(value: 8)),
          Text(
            title,
            style: AppTextStyles.bold20,
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: AppTextStyles.semiBold16,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MyResponsive.height(value: 4)),
          Text(
            price,
            style: AppTextStyles.semiBold13,


            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
