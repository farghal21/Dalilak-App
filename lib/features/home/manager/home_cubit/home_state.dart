import '../../data/models/message_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeMessagesUpdated extends HomeState {}

class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});
}
