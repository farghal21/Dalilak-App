import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/user/manager/user_cubit/user_cubit.dart';
import '../../home/data/models/send_chat_messages_response_model.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  static FavoriteCubit get(context) => BlocProvider.of(context);

  List<CarModel> favoriteCars = [];

  void init(List<CarModel> cars) {
    favoriteCars = List.from(cars);
    emit(FavoriteLoaded());
  }

  void removeFromFavorite({
    required CarModel car,
    required UserCubit userCubit,
  }) {
    favoriteCars.remove(car);
    userCubit.favoriteCars.remove(car);

    emit(FavoriteUpdated());
  }
}
