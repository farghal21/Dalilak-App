import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'compare_state.dart';

class CompareCubit extends Cubit<CompareState> {
  CompareCubit() : super(CompareInitial());

  static CompareCubit get(context) => BlocProvider.of(context);

  List<CarModel> comparedCars = [];

  void saveComparedCars(List<CarModel> cars) {
    comparedCars = List.from(cars);
    emit(CompareUpdated());
  }

  void removeCar(CarModel car, UserCubit userCubit) {
    comparedCars.removeWhere((c) => c.id == car.id);
    userCubit.comparedCars.removeWhere((c) => c.id == car.id);
    emit(CompareUpdated());
  }

  void clear(UserCubit userCubit) {
    userCubit.comparedCars.clear();
    comparedCars.clear();
    emit(CompareUpdated());
  }
}
