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
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obsecure = true; // المتغير اللي بيتحكم في إظهار/إخفاء النص

  void togglePasswordVisibility() {
    obsecure = !obsecure; // بيعكس الحالة
    emit(UserChangePasswordVisibilityState()); // بيبعت إشارة للـ UI عشان يتحدث
  }

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

        // تصفير الباسورد عند جلب بيانات جديدة لضمان نظافة الحقل
        passwordController.clear();

        emit(UserGetSuccess(userModel: user));
        return true;
      },
    );
  }

  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  ImageManagerCubit imageCubit = ImageManagerCubit();

  /// دالة اختيار الصورة
  Future<void> pickProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = image;
      emit(UserImageSelectedState());
    }
  }

  /// حفظ البيانات مع معالجة ذكية للباسورد
  void saveProfileData() async {
    // 1. كشف التغييرات باستخدام trim
    bool isEmailChanged = emailController.text.trim() != userModel.email;
    bool isNameChanged = nameController.text.trim() != userModel.fullName;
    bool isImageChanged = imageFile != null;

    // 2. التحقق اليدوي لتجنب توقف الـ FormKey الصامت
    if (isEmailChanged) {
      // عند تغيير الإيميل نتحقق من وجود الباسورد
      if (passwordController.text.isEmpty) {
        emit(UserUpdateError(
            error: "كلمة المرور مطلوبة لتغيير البريد الإلكتروني"));
        return;
      }
      // التحقق من صحة الإيميل يدوياً أو عبر الـ Form
      if (emailController.text.trim().isEmpty ||
          !emailController.text.contains('@')) {
        emit(UserUpdateError(error: "يرجى إدخال بريد إلكتروني صحيح"));
        return;
      }
    } else if (isNameChanged || isImageChanged) {
      if (nameController.text.trim().isEmpty) {
        emit(UserUpdateError(error: "الاسم مطلوب"));
        return;
      }
    } else {
      // لم يحدث أي تغيير، لا داعي لإرسال طلب
      return;
    }

    // 3. بدء عملية التحديث
    emit(UserUpdateLoading());

    var result = await userRepo.updateUserData(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      imageFile: imageFile,
    );

    result.fold(
      (String error) {
        passwordController.clear();
        emit(UserUpdateError(error: error));
      },
      (message) {
        passwordController.clear();
        imageFile = null;

        if (isEmailChanged) {
          emit(UserUpdateNeedsVerification(email: emailController.text.trim()));
        } else {
          // تحديث محلي سريع للاسم
          userModel.fullName = nameController.text.trim();

          // إذا تغيرت الصورة، نطلب البيانات مجدداً لجلب الرابط الجديد
          if (isImageChanged) {
            getUserData();
          }

          emit(UserUpdateSuccess(message: message));
        }
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
    MyNavigator.goTo(screen: () => const LoginView(), isReplace: true);
  }
}
