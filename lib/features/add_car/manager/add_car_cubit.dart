import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  AddCarCubit() : super(AddCarInitial());

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Egyptian Cities List
  static final List<String> cities = [
    'القاهرة',
    'الجيزة',
    'الإسكندرية',
    'الشرقية',
    'الدقهلية',
    'القليوبية',
    'المنيا',
    'الغربية',
    'سوهاج',
    'أسيوط',
    'البحيرة',
    'الفيوم',
    'المنوفية',
    'بني سويف',
    'قنا',
    'أسوان',
    'الأقصر',
    'البحر الأحمر',
    'الوادي الجديد',
    'مطروح',
  ];

  // Text controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Image picker
  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = [];
  String? selectedCity;

  // Pick multiple images from gallery
  Future<void> pickImages() async {
    try {
      emit(AddCarImagePicking());

      final List<XFile> images = await _picker.pickMultiImage();

      if (images.isNotEmpty) {
        selectedImages.addAll(images);
        emit(AddCarImagePicked());
      } else {
        emit(AddCarInitial());
      }
    } catch (e) {
      emit(AddCarError('فشل في اختيار الصور: ${e.toString()}'));
      emit(AddCarInitial());
    }
  }

  // Remove image at specific index
  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
      emit(AddCarImagePicked());
    }
  }

  // Change City
  void changeCity(String? value) {
    selectedCity = value;
    emit(AddCarInitial());
  }

  // Submit the ad
  Future<void> submitAd() async {
    // Validate form
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Validate images
    if (selectedImages.isEmpty) {
      emit(AddCarError(
          'يرجى اختيار صورة واحدة على الأقل')); // Assuming AppStrings.selectAtLeastOneImage is not defined yet, keeping the original string for now.
      return;
    }

    // Validate city selection
    if (selectedCity == null || selectedCity!.isEmpty) {
      emit(AddCarError('من فضلك اختر المدينة'));
      return;
    }

    try {
      emit(AddCarLoading());

      // TODO: Implement API call to submit the ad
      // For now, simulate a successful submission
      await Future.delayed(const Duration(seconds: 2));

      // Clear form after successful submission
      nameController.clear();
      priceController.clear();
      descriptionController.clear();
      phoneController.clear();
      selectedImages.clear();

      emit(AddCarSuccess('تم نشر الإعلان بنجاح'));
    } catch (e) {
      emit(AddCarError('فشل في نشر الإعلان: ${e.toString()}'));
    }
  }

  // Get cubit instance
  static AddCarCubit get(BuildContext context) => BlocProvider.of(context);

  @override
  Future<void> close() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
