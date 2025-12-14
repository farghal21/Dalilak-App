import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/utils/app_assets.dart';
import 'package:dalilak_app/features/car_details/car_details_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../chat_history/views/widgets/history_app_bar.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: MyResponsive.height(value: 140)),
          HistoryAppBar(title: AppStrings.favorite,),
          SizedBox(height: MyResponsive.height(value: 30)),

      Container(
      width: double.infinity,
      padding: MyResponsive.paddingSymmetric(
      horizontal: 20,
      vertical: 15,
      ),
      decoration: BoxDecoration(
      color: AppColors.fillColor,
      borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
      ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      InkWell(
        onTap: (){
          Navigator.pushNamed(context, CarDetailsView.routeName);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
              child: Image.asset(AppAssets.car1 , fit: BoxFit.cover, width: MyResponsive.width(value: 150),),

            ),
            SizedBox(
            width: MyResponsive.width(value: 50),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Text("مرسيدس C200" , style: AppTextStyles.bold20,),
                SizedBox(
                  height: MyResponsive.height(value: 10),
                ), Text("SubTitle" , style: AppTextStyles.semiBold16,),
                SizedBox(
                  height: MyResponsive.height(value: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,

                  ),
                  child: Text(
                    AppStrings.remove,
                    style:
                    AppTextStyles.regular11.copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),



      ],
      ),
      )



        ],
      ),
    );
  }
}