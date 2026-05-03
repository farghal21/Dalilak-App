import 'dart:io';
import 'package:dalilak_app/core/helper/get_it.dart';
import 'package:dalilak_app/core/shared_widgets/custom_scaffold.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/used_cars/manager/used_cars_cubit/used_cars_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

/// AddCarView - Screen for adding a new used car
/// Uses BlocConsumer to handle state and navigation
class AddCarView extends StatelessWidget {
  const AddCarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UsedCarsCubit>(),
      child: CustomScaffold(
        drawerSelectedIndex: 7,
        isHomeScreen: true,
        appBar: AppBar(
          title: Text(
            'إضافة عربية',
            style: AppTextStyles.semiBold20.copyWith(color: AppColors.white),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: AppColors.horizontalGradient,
            ),
          ),
          iconTheme: IconThemeData(color: AppColors.white),
        ),
        body: const AddCarViewBody(),
      ),
    );
  }
}

class AddCarViewBody extends StatefulWidget {
  const AddCarViewBody({super.key});

  @override
  State<AddCarViewBody> createState() => _AddCarViewBodyState();
}

class _AddCarViewBodyState extends State<AddCarViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _yearController = TextEditingController();

  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  /// Pick multiple images from gallery
  Future<void> _pickImages() async {
    if (_selectedImages.length >= 10) {
      _showSnackBar(
        'الحد الأقصى 10 صور',
        isError: true,
      );
      return;
    }

    try {
      final pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        final remainingSlots = 10 - _selectedImages.length;
        final filesToAdd = pickedFiles.take(remainingSlots);

        setState(() {
          _selectedImages.addAll(
            filesToAdd.map((xFile) => File(xFile.path)),
          );
        });
      }
    } catch (e) {
      _showSnackBar(
        'خطأ في اختيار الصور: $e',
        isError: true,
      );
    }
  }

  /// Remove image from selected list
  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  /// Submit form and add car
  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate images
    if (_selectedImages.isEmpty) {
      _showSnackBar(
        'يجب اختيار صورة واحدة على الأقل',
        isError: true,
      );
      return;
    }

    // Parse price
    final price = double.tryParse(_priceController.text);
    if (price == null || price <= 0) {
      _showSnackBar(
        'يرجى إدخال سعر صحيح',
        isError: true,
      );
      return;
    }

    // Parse year (optional)
    int? year;
    if (_yearController.text.isNotEmpty) {
      year = int.tryParse(_yearController.text);
      if (year == null || year < 1900 || year > DateTime.now().year) {
        _showSnackBar(
          'يرجى إدخال سنة صحيحة',
          isError: true,
        );
        return;
      }
    }

    // Call cubit to add car
    context.read<UsedCarsCubit>().addCar(
          name: _nameController.text.trim(),
          price: price,
          description: _descriptionController.text.trim(),
          city: _cityController.text.trim(),
          buyerPhoneNumber: _phoneController.text.trim(),
          images: _selectedImages,
          createdAtYear: year,
        );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsedCarsCubit, UsedCarsState>(
      listener: (context, state) {
        if (state is AddCarSuccess) {
          _showSnackBar('تم إضافة السيارة بنجاح!');
          Navigator.pop(context, true);
        } else if (state is AddCarFailure) {
          _showSnackBar(state.error, isError: true);
        }
      },
      builder: (context, state) {
        final isLoading = state is AddCarLoading;

        return SafeArea(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 100, // Extra padding for keyboard and submit button
                  ),
                  children: [
                    // Hero Section: Image Upload Zone
                    _buildModernImageUploadZone(),
                    const SizedBox(height: 24),

                    // Car Name Field (Full Width)
                    _buildModernTextField(
                      controller: _nameController,
                      label: 'اسم السيارة',
                      hint: 'مثال: تويوتا كورولا 2020',
                      icon: Icons.directions_car,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يرجى إدخال اسم السيارة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Smart Grid Layout: Row 1 - Price + Year
                    Row(
                      children: [
                        Expanded(
                          child: _buildModernTextField(
                            controller: _priceController,
                            label: 'السعر (جنيه)',
                            hint: '150000',
                            icon: Icons.attach_money,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'يرجى إدخال السعر';
                              }
                              final price = double.tryParse(value);
                              if (price == null || price <= 0) {
                                return 'سعر غير صحيح';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildModernTextField(
                            controller: _yearController,
                            label: 'سنة الصنع',
                            hint: '2015',
                            icon: Icons.calendar_today,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Smart Grid Layout: Row 2 - City + Phone
                    Row(
                      children: [
                        Expanded(
                          child: _buildModernTextField(
                            controller: _cityController,
                            label: 'المدينة',
                            hint: 'القاهرة',
                            icon: Icons.location_city,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'يرجى إدخال المدينة';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildModernTextField(
                            controller: _phoneController,
                            label: 'رقم الهاتف',
                            hint: '01234567890',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'يرجى إدخال الهاتف';
                              }
                              if (value.length < 11) {
                                return 'رقم غير صحيح';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Description Field (Full Width - Text Area)
                    _buildModernTextField(
                      controller: _descriptionController,
                      label: 'الوصف',
                      hint: 'وصف تفصيلي للسيارة...',
                      icon: Icons.description,
                      minLines: 3,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يرجى إدخال وصف السيارة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),

              // Fixed Bottom Submit Button
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor:
                          AppColors.primary.withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.white),
                            ),
                          )
                        : Text(
                            'إضافة السيارة',
                            style: AppTextStyles.bold18
                                .copyWith(color: AppColors.white),
                          ),
                  ),
                ),
              ),

              // Loading Overlay
              if (isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: AppColors.cardGradient,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'جاري إضافة السيارة...',
                            style: AppTextStyles.semiBold16.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// Modern Image Upload Zone with Dashed Border
  Widget _buildModernImageUploadZone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with Counter
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'صور العربية',
              style: AppTextStyles.bold18.copyWith(
                color: AppColors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.2),
                    AppColors.secondary.withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                '${_selectedImages.length}/10 Selected',
                style: AppTextStyles.semiBold14.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Empty State: Dashed Border Drop Zone
        if (_selectedImages.isEmpty)
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: CustomPaint(
                painter: DashedBorderPainter(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  strokeWidth: 2,
                  dashWidth: 8,
                  dashSpace: 6,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.cloud_upload_outlined,
                          size: 48,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'اضغط لرفع الصور',
                        style: AppTextStyles.semiBold16.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'يجب اختيار صورة واحدة على الأقل',
                        style: AppTextStyles.regular12.copyWith(
                          color: AppColors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        // Filled State: Horizontal List of Images
        if (_selectedImages.isNotEmpty) ...[
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: 104,
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _selectedImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Red X Button (Top-Right)
                    Positioned(
                      top: 4,
                      left: 12,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Add More Button
          if (_selectedImages.length < 10)
            OutlinedButton.icon(
              onPressed: _pickImages,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: AppColors.primary.withValues(alpha: 0.05),
              ),
              icon: Icon(Icons.add_photo_alternate, color: AppColors.primary),
              label: Text(
                'إضافة المزيد من الصور',
                style: AppTextStyles.semiBold14.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ],
    );
  }

  /// Modern Text Field with 16px Border Radius and Light Grey Fill
  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int minLines = 1,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      minLines: minLines,
      maxLines: maxLines,
      style: AppTextStyles.regular16.copyWith(color: AppColors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.regular14.copyWith(
          color: AppColors.white.withValues(alpha: 0.7),
        ),
        hintText: hint,
        hintStyle: AppTextStyles.regular14.copyWith(
          color: AppColors.white.withValues(alpha: 0.4),
        ),
        prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.white.withValues(alpha: 0.1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.white.withValues(alpha: 0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: AppColors.white.withValues(alpha: 0.05),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        errorStyle: AppTextStyles.regular12.copyWith(color: Colors.red),
      ),
      validator: validator,
    );
  }
}

/// Custom Painter for Dashed Border
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 2,
    this.dashWidth = 8,
    this.dashSpace = 6,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2,
              size.width - strokeWidth, size.height - strokeWidth),
          const Radius.circular(16),
        ),
      );

    final dashPath = _createDashedPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final length = draw ? dashWidth : dashSpace;
        if (distance + length > metric.length) {
          if (draw) {
            dest.addPath(
              metric.extractPath(distance, metric.length),
              Offset.zero,
            );
          }
          break;
        }
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
