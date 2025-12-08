import 'package:dalilak_app/features/settings/manager/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/shared_widgets/image_manager/cubit/image_manager_cubit.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  XFile? imageFile;
  ImageManagerCubit imageCubit = ImageManagerCubit();

  void saveProfileData() {
    emit(ProfileLoading());

    Future.delayed(const Duration(seconds: 2), () {
      emit(ProfileSuccess());
    });
  }

  void updateImage() {
    imageCubit.pickImage();
  }

  void deleteImage() {
    imageFile = null;
    imageCubit.resetImage();
  }

  Future<void> copyUserId() async {
    await Clipboard.setData(
      ClipboardData(text: "3309449812"),
    );
  }
}
