import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'cubit/image_manager_cubit.dart';
import 'cubit/image_manager_state.dart';

class ImageManagerView extends StatelessWidget {
  const ImageManagerView({
    super.key,
    required this.onPicked,
    this.pickedBody,
    this.unPickedBody,
  });

  final void Function(XFile image) onPicked;
  final Widget Function(XFile image)? pickedBody;
  final Widget? unPickedBody;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageManagerCubit(),
      child: BlocConsumer<ImageManagerCubit, ImageManagerState>(
        listener: (context, state) {
          if (state is ImageManagerPickedImage) {
            onPicked(state.imageFile);
          }
        },
        builder: (context, state) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              ImageManagerCubit.get(context).pickImage();
            },
            child: Builder(
              builder: (context) {
                if (state is ImageManagerPickedImage) {
                  if (pickedBody != null) return pickedBody!(state.imageFile);
                  return Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(state.imageFile.path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
                if (unPickedBody != null) {
                  return unPickedBody!;
                }
                return IconButton(onPressed: () {}, icon: Icon(Icons.image));
              },
            ),
          );
        },
      ),
    );
  }
}
