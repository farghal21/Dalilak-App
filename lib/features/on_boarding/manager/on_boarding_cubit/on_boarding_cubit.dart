import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../views/widgets/user_discover_app_source_page_widget.dart';
import '../../views/widgets/user_goal_page_widget.dart';
import '../../views/widgets/user_type_page_widget.dart';
import 'on_boarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  static OnboardingCubit get(context) => BlocProvider.of(context);

  final PageController pageController = PageController();

  int currentPage = 0;
  int userTypeSelected = -1;
  int userGoalSelected = -1;
  int userDiscoverSelected = -1;

  // pages List
  List<Widget> pages = [
    UserTypePageWidget(),
    UserGoalPageWidget(),
    UserDiscoverAppSourcePageWidget(),
  ];

  // user type List
  List<String> userTypes = [
    AppStrings.userTypePerformance,
    AppStrings.userTypeFuelSaving,
    AppStrings.userTypeReliability,
    AppStrings.userTypeLuxury,
    AppStrings.userTypeOtherReason,
  ];

  // user goal List
  List<String> userGoals = [
    AppStrings.userGoal1,
    AppStrings.userGoal2,
    AppStrings.userGoal3,
  ];

  // user discover app source List
  List<String> discoverOptions = [
    AppStrings.discover1,
    AppStrings.discover2,
    AppStrings.discover3,
  ];

  void selectUserType(int index) {
    userTypeSelected = index;
    emit(OnboardingSelected());
  }

  void selectUserGoal(int index) {
    userGoalSelected = index;
    emit(OnboardingSelected());
  }

  void selectUserDiscover(int index) {
    userDiscoverSelected = index;
    emit(OnboardingSelected());
  }

  void finish() {
    emit(OnboardingLoading());

    // Logic to finish onboarding
    Future.delayed(const Duration(seconds: 2), () {
      emit(OnboardingFinished());
    });
  }

  void nextPage() {
    if (currentPage < pages.length - 1) {
      currentPage++;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(OnboardingPageChanged());
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(OnboardingPageChanged());
    }
  }

  void pageChanged(int index) {
    currentPage = index;
    emit(OnboardingPageChanged());
  }

  bool get nextTurnOn {
    if (currentPage == 0) {
      return userTypeSelected > -1;
    } else if (currentPage == 1) {
      return userGoalSelected > -1;
    } else {
      return userDiscoverSelected > -1;
    }
  }

  bool isLastPage() {
    return currentPage == pages.length - 1;
  }
}
