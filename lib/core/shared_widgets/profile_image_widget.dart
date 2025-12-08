import 'dart:io';
import 'package:flutter/material.dart';

import '../helper/my_responsive.dart';
import '../utils/app_assets.dart';
import 'cached_network_image_wrapper.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;
  final bool isLocalFile;

  const ProfileImageWidget({
    super.key,
    this.imagePath,
    this.width,
    this.height,
    this.isLocalFile = false,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: MyResponsive.width(value: 63),
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: imagePath != null
            ? isLocalFile
                ? Image.file(
                    File(imagePath!),
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImageWrapper(
                    imagePath: imagePath!,
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                  )
            : Image.asset(AppAssets.profileImage, fit: BoxFit.cover),
      ),
    );
  }
}
