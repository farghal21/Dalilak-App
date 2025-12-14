abstract class SliderState {}

class SliderInitial extends SliderState {}

class SliderIndexChanged extends SliderState {
  final int currentIndex;

  SliderIndexChanged({required this.currentIndex});
}
