part of 'add_car_cubit.dart';

abstract class AddCarState {}

class AddCarInitial extends AddCarState {}

class AddCarImagePicking extends AddCarState {}

class AddCarImagePicked extends AddCarState {}

class AddCarLoading extends AddCarState {}

class AddCarSuccess extends AddCarState {
  final String message;

  AddCarSuccess(this.message);
}

class AddCarError extends AddCarState {
  final String message;

  AddCarError(this.message);
}
