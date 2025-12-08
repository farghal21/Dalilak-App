abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingFinished extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String errorMessage;

  OnboardingError(this.errorMessage);
}

class OnboardingPageChanged extends OnboardingState {}

class OnboardingSelected extends OnboardingState {}
