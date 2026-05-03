import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';

/// Widget for displaying and managing selected images in the form
class ImageGridView extends StatelessWidget {
  final List<File> images;
  final VoidCallback onAddImages;
  final Function(int) onRemoveImage;
  final int maxImages;

  const ImageGridView({
    super.key,
    required this.images,
    required this.onAddImages,
    required this.onRemoveImage,
    this.maxImages = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: images.length + (images.length < maxImages ? 1 : 0),
      itemBuilder: (context, index) {
        // Add Image Button
        if (index == images.length) {
          return GestureDetector(
            onTap: onAddImages,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A3E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.5),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    size: 40,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'إضافة صورة',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Image Preview with Remove Button
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                images[index],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => onRemoveImage(index),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
