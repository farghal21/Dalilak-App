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
    required this.cubit, // 👈 أضف ده
  });

  final void Function(XFile image) onPicked;
  final Widget Function(XFile image)? pickedBody;
  final Widget? unPickedBody;
  final ImageManagerCubit cubit; // 👈 أضف ده

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageManagerCubit, ImageManagerState>(
      bloc: cubit, // 👈 استخدمه هنا بدل BlocProvider
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
            cubit.pickImage(); // 👈 نادِيه مباشرة
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
              return const Icon(Icons.image);
            },
          ),
        );
      },
    );
  }
}
