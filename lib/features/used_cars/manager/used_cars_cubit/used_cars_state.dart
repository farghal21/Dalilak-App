part of 'used_cars_cubit.dart';

/// Base state for Used Cars feature
abstract class UsedCarsState {}

/// Initial state
class UsedCarsInitial extends UsedCarsState {}

// ============================================================================
// ADD CAR STATES
// ============================================================================

/// Loading state when adding a new car
class AddCarLoading extends UsedCarsState {}

/// Success state when car is added successfully
class AddCarSuccess extends UsedCarsState {
  final String carId;

  AddCarSuccess({required this.carId});
}

/// Failure state when adding car fails
class AddCarFailure extends UsedCarsState {
  final String error;

  AddCarFailure({required this.error});
}

// ============================================================================
// GET ALL CARS STATES
// ============================================================================

/// Loading state when fetching cars (initial load)
class UsedCarsLoading extends UsedCarsState {}

/// Success state when cars are loaded
class UsedCarsLoaded extends UsedCarsState {
  final List<CarModel> cars;
  final int totalCount;
  final int currentPage;
  final int totalPages;
  final bool hasMorePages;

  UsedCarsLoaded({
    required this.cars,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
    required this.hasMorePages,
  });
}

/// Loading state when fetching more cars (pagination)
class LoadingMoreCars extends UsedCarsState {
  final List<CarModel> currentCars;

  LoadingMoreCars({required this.currentCars});
}

/// Failure state when fetching cars fails
class UsedCarsFailure extends UsedCarsState {
  final String error;

  UsedCarsFailure({required this.error});
}
