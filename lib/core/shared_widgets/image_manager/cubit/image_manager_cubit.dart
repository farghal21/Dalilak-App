import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'image_manager_state.dart';

class ImageManagerCubit extends Cubit<ImageManagerState> {
  ImageManagerCubit() : super(ImageManagerInitial());

  static ImageManagerCubit get(context) => BlocProvider.of(context);

  void pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      emit(ImageManagerPickedImage(imageFile: imageFile));
    }
  }
}
