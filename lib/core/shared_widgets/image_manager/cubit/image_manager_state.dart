import 'package:image_picker/image_picker.dart';

abstract class ImageManagerState {}

class ImageManagerInitial extends ImageManagerState {}

class ImageManagerPickedImage extends ImageManagerState {
  final XFile imageFile;

  ImageManagerPickedImage({required this.imageFile});
}
