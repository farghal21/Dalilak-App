import 'package:dalilak_app/core/cache/cache_data.dart';
import 'package:dalilak_app/core/cache/cache_key.dart';
import 'package:dalilak_app/core/helper/my_navigator.dart';
import 'package:dalilak_app/core/shared_widgets/custom_scaffold.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/auth/views/login_view.dart';
import 'package:dalilak_app/features/onboarding/view/widget/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/helper/my_responsive.dart';
import '../manager/cubit/on_boarding_cubit.dart';
import '../manager/cubit/on_boarding_state.dart';
import 'widget/custom_indicator.dart';

class OnBoardingView extends StatelessWidget {
  static const String routeName = "onBoarding";

  const OnBoardingView({super.key});

  // دالة لإنهاء الـ OnBoarding وحفظ البيانات
  void _finishOnBoarding(BuildContext context) {
    CacheHelper.saveData(key: CacheKeys.firstTime, value: true);
    CacheData.firstTime = true;

    MyNavigator.goTo(
      screen: LoginView(),
      isReplace: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocProvider(
        create: (context) => OnBoardingCubit(),
        child: Builder(builder: (context) {
          OnBoardingCubit onBoardingCubit = OnBoardingCubit.get(context);
          return BlocConsumer<OnBoardingCubit, OnBoardingState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
                padding:
                    MyResponsive.paddingSymmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: MyResponsive.height(value: 50),
                    ),
                    // --- زر التخطي (Skip) ---
                    Row(
                      children: [
                        const Spacer(),
                        // يختفي الزر في آخر صفحة
                        onBoardingCubit.currentIndex ==
                                onBoardingCubit.pages.length - 1
                            ? SizedBox(height: MyResponsive.height(value: 30))
                            : AppTextButton(
                                text: AppStrings
                                    .skip, // تأكد أن هذا النص هو "تخطي"
                                textStyle: AppTextStyles.regular14
                                    .copyWith(color: AppColors.white),
                                onPressed: () {
                                  _finishOnBoarding(context);
                                },
                              ),
                      ],
                    ),

                    // --- محتوى الصفحات ---
                    Expanded(
                      child: PageView.builder(
                        itemCount: onBoardingCubit.pages.length,
                        onPageChanged: (index) {
                          onBoardingCubit.changePage(index);
                        },
                        controller: onBoardingCubit.pageController,
                        itemBuilder: (context, index) {
                          return onBoardingCubit.pages[index];
                        },
                      ),
                    ),

                    // --- الجزء السفلي (مؤشرات وأزرار) ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 1. زر العودة (أو مساحة فارغة في أول صفحة)
                        onBoardingCubit.currentIndex == 0
                            ? SizedBox(
                                width: MyResponsive.width(
                                    value: 50)) // مساحة لحفظ التوازن
                            : SizedBox(
                                width: MyResponsive.width(
                                    value:
                                        50)), // ممكن تضيف زر رجوع هنا لو حابب

                        // 2. المؤشرات (Indicators) الديناميكية
                        Row(
                          children: List.generate(
                            onBoardingCubit.pages.length,
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MyResponsive.width(value: 2.5)),
                              child: CustomIndicator(
                                isActive: onBoardingCubit.currentIndex == index,
                              ),
                            ),
                          ),
                        ),

                        // 3. زر التالي / ابدأ
                        AppTextButton(
                          text: onBoardingCubit.currentIndex ==
                                  onBoardingCubit.pages.length - 1
                              ? AppStrings.start // "ابدأ"
                              : AppStrings.next, // "التالي"
                          textStyle: AppTextStyles.regular14.copyWith(
                              color: AppColors.white), // لون مميز للزر

                          onPressed: () {
                            if (onBoardingCubit.currentIndex ==
                                onBoardingCubit.pages.length - 1) {
                              // لو في آخر صفحة، احفظ وانتقل
                              _finishOnBoarding(context);
                            } else {
                              // لو لسه، روح للصفحة اللي بعدها
                              onBoardingCubit.pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: MyResponsive.height(value: 20)),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
