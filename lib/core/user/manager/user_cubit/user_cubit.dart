import 'package:dalilak_app/core/cache/cache_helper.dart';
import 'package:dalilak_app/core/cache/cache_key.dart';
import 'package:dalilak_app/core/helper/my_navigator.dart';
import 'package:dalilak_app/core/shared_widgets/image_manager/cubit/image_manager_cubit.dart';
import 'package:dalilak_app/core/user/data/models/user_model.dart';
import 'package:dalilak_app/core/user/data/repo/user_repo.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_state.dart';
import 'package:dalilak_app/features/auth/views/login_view.dart';
import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepo) : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  /// Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Data
  UserModel userModel = UserModel();
  CarModel? selectedCar;
  List<CarModel> favoriteCars = [];
  List<CarModel> comparedCars = [];

  final UserRepo userRepo;

  /// get user data
  Future<bool> getUserData() async {
    emit(UserLoading());
    var response = await userRepo.getUserData();
    return response.fold(
      (error) {
        emit(UserGetError(error: error));
        return false;
      },
      (user) {
        userModel = user;

        nameController.text = userModel.fullName ?? '';
        emailController.text = userModel.email ?? '';
        emit(UserGetSuccess(userModel: user));
        return true;
      },
    );
  }

  XFile? imageFile;
  ImageManagerCubit imageCubit = ImageManagerCubit();

  void saveProfileData() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(UserUpdateLoading());
    var result = await userRepo.updateUserData(
      name: nameController.text,
      email: emailController.text,
      imageFile: imageFile,
    );

    result.fold(
      (String error) {
        emit(UserUpdateError(error: error));
      },
      (message) {
        userModel.fullName = nameController.text;
        userModel.email = emailController.text;
        emit(UserUpdateSuccess(message: message));
      },
    );
  }

  Future<void> copyUserId() async {
    await Clipboard.setData(
      ClipboardData(text: userModel.id.toString()),
    );
  }

  Future<void> logout() async {
    await CacheHelper.removeData(key: CacheKeys.accessToken);
    await CacheHelper.removeData(key: CacheKeys.refreshToken);
    MyNavigator.goTo(screen: LoginView(), isReplace: true);
  }
}
