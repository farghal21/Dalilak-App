import 'package:flutter/material.dart';

import 'app_network_image.dart';

class CachedNetworkImageWrapper extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const CachedNetworkImageWrapper({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return AppNetworkImage(
      imageUrl: imagePath,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
