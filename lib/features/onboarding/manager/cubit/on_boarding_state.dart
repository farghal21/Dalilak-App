abstract class OnBoardingState {}

class OnBoardingInitialState extends OnBoardingState {}

class OnBoardingChangePageState extends OnBoardingState {
  OnBoardingChangePageState();
}

class OnBoardingErrorState extends OnBoardingState {
  final String error;

  OnBoardingErrorState({required this.error});
}
