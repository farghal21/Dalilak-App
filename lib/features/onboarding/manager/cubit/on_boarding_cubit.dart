import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/features/auth/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_data.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/cache/cache_key.dart';
import '../../../../core/helper/my_navigator.dart';
import '../../../../core/utils/app_assets.dart';
import '../../view/widget/custom_page.dart';
import 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  final PageController pageController = PageController();

  // قائمة الصفحات منظمة وتستخدم AppStrings و AppAssets
  final List<Widget> pages = [
    const CustomPage(
      imagePath: AppAssets.onBoarding2, // تأكد من وجود هذه الصورة في AppAssets
      title: AppStrings.onBoardingTitle1,
      description: AppStrings.onBoardingSubTitle1,
    ),
    const CustomPage(
      imagePath: AppAssets.onBoarding1, // تأكد من وجود هذه الصورة في AppAssets

      title: AppStrings.onBoardingTitle2,
      description: AppStrings.onBoardingSubTitle2,
    ),
    const CustomPage(
      imagePath: AppAssets.onBoarding3, // تأكد من وجود هذه الصورة في AppAssets

      title: AppStrings.onBoardingTitle3,
      description: AppStrings.onBoardingSubTitle3,
    ),
  ];

  void changePage(int index) {
    currentIndex = index;
    emit(OnBoardingChangePageState());
  }

  void nextPage(BuildContext context) {
    if (currentIndex < pages.length - 1) {
      currentIndex++;
      pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(OnBoardingChangePageState());
    } else {
      _finishOnBoarding(context);
    }
  }

  // دالة موحدة للإنهاء (سواء من زر Skip أو Done)
  void _finishOnBoarding(BuildContext context) {
    CacheHelper.saveData(key: CacheKeys.firstTime, value: true);
    CacheData.firstTime = true;

    MyNavigator.goTo(
      screen: () => const LoginView(),
      isReplace: true,
    );
  }

  // دالة التخطي (Public)
  void skip(BuildContext context) {
    _finishOnBoarding(context);
  }
}
