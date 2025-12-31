import 'dart:io';
import 'package:dalilak_app/features/used_cars/data/models/car_model.dart';
import 'package:dalilak_app/features/used_cars/data/repo/used_cars_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'used_cars_state.dart';

/// Cubit for managing Used Cars business logic
/// Calls repository directly for data operations
class UsedCarsCubit extends Cubit<UsedCarsState> {
  final UsedCarsRepository _repository;

  UsedCarsCubit(this._repository) : super(UsedCarsInitial());

  // Cached data for pagination
  List<CarModel> _allCars = [];
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalCount = 0;
  bool _hasMorePages = false;

  // Getters
  List<CarModel> get allCars => _allCars;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalCount => _totalCount;
  bool get hasMorePages => _currentPage < _totalPages;

  /// Add a new used car with images
  ///
  /// Parameters:
  /// - [name]: Car name/model
  /// - [price]: Car price
  /// - [description]: Car description
  /// - [city]: City location
  /// - [buyerPhoneNumber]: Contact phone number
  /// - [images]: List of image files (1-10 images required)
  /// - [createdAtYear]: Optional year (defaults to current year)
  ///
  /// Emits:
  /// - AddCarLoading: When starting the upload
  /// - AddCarSuccess: When car is added successfully (with car ID)
  /// - AddCarFailure: When an error occurs (with error message)
  Future<void> addCar({
    required String name,
    required double price,
    required String description,
    required String city,
    required String buyerPhoneNumber,
    required List<File> images,
    int? createdAtYear,
  }) async {
    emit(AddCarLoading());

    try {
      // Create CarModel
      final carData = CarModel(
        id: '', // Will be assigned by backend
        name: name,
        price: price,
        description: description,
        city: city,
        buyerPhoneNumber: buyerPhoneNumber,
        images: [], // Will be populated by backend
        createdAtYear: createdAtYear ?? DateTime.now().year,
      );

      // Call repository directly
      final result = await _repository.addCar(
        carData: carData,
        images: images,
      );

      result.fold(
        (error) => emit(AddCarFailure(error: error)),
        (carId) => emit(AddCarSuccess(carId: carId)),
      );
    } catch (e) {
      emit(AddCarFailure(error: 'An unexpected error occurred: $e'));
    }
  }

  /// Get all used cars (first page)
  /// Resets pagination and fetches page 1
  ///
  /// Parameters:
  /// - [pageSize]: Items per page (default: 10)
  ///
  /// Emits:
  /// - UsedCarsLoading: When starting to fetch
  /// - UsedCarsLoaded: When cars are loaded successfully
  /// - UsedCarsFailure: When an error occurs
  Future<void> getAllCars({int pageSize = 10}) async {
    emit(UsedCarsLoading());

    try {
      // Call repository directly
      final result = await _repository.getAllCars(
        page: 1,
        pageSize: pageSize,
      );

      result.fold(
        (error) => emit(UsedCarsFailure(error: error)),
        (data) {
          _allCars = data['cars'] as List<CarModel>;
          _currentPage = data['page'] as int;
          _totalPages = data['totalPages'] as int;
          _totalCount = data['totalCount'] as int;
          _hasMorePages = _currentPage < _totalPages;

          emit(UsedCarsLoaded(
            cars: _allCars,
            totalCount: _totalCount,
            currentPage: _currentPage,
            totalPages: _totalPages,
            hasMorePages: _hasMorePages,
          ));
        },
      );
    } catch (e) {
      emit(UsedCarsFailure(error: 'An unexpected error occurred: $e'));
    }
  }

  /// Load more cars (next page)
  /// Appends new cars to existing list
  ///
  /// Parameters:
  /// - [pageSize]: Items per page (should match initial page size)
  ///
  /// Emits:
  /// - LoadingMoreCars: When fetching next page
  /// - UsedCarsLoaded: When more cars are loaded
  /// - UsedCarsFailure: When an error occurs
  Future<void> loadMoreCars({int pageSize = 10}) async {
    // Don't load if already loading or no more pages
    if (state is LoadingMoreCars || !_hasMorePages) {
      return;
    }

    emit(LoadingMoreCars(currentCars: _allCars));

    try {
      final nextPage = _currentPage + 1;
      // Call repository directly
      final result = await _repository.getAllCars(
        page: nextPage,
        pageSize: pageSize,
      );

      result.fold(
        (error) {
          // Restore previous state
          emit(UsedCarsLoaded(
            cars: _allCars,
            totalCount: _totalCount,
            currentPage: _currentPage,
            totalPages: _totalPages,
            hasMorePages: _hasMorePages,
          ));
          emit(UsedCarsFailure(error: error));
        },
        (data) {
          // Append new cars
          final newCars = data['cars'] as List<CarModel>;
          _allCars.addAll(newCars);
          _currentPage = data['page'] as int;
          _totalPages = data['totalPages'] as int;
          _totalCount = data['totalCount'] as int;
          _hasMorePages = _currentPage < _totalPages;

          emit(UsedCarsLoaded(
            cars: _allCars,
            totalCount: _totalCount,
            currentPage: _currentPage,
            totalPages: _totalPages,
            hasMorePages: _hasMorePages,
          ));
        },
      );
    } catch (e) {
      emit(UsedCarsFailure(error: 'An unexpected error occurred: $e'));
    }
  }

  /// Refresh cars list (reload page 1)
  /// Useful for pull-to-refresh functionality
  Future<void> refreshCars({int pageSize = 10}) async {
    await getAllCars(pageSize: pageSize);
  }

  /// Get full image URL for a relative path
  /// Delegates to repository method
  String getFullImageUrl(String relativePath) {
    return _repository.getFullImageUrl(relativePath);
  }

  /// Reset state to initial
  void resetState() {
    _allCars = [];
    _currentPage = 1;
    _totalPages = 1;
    _totalCount = 0;
    _hasMorePages = false;
    emit(UsedCarsInitial());
  }
}
