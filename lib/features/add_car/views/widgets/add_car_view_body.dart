import 'dart:io';
import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/helper/validator.dart';
import 'package:dalilak_app/core/shared_widgets/custom_button.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/add_car/manager/add_car_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCarViewBody extends StatelessWidget {
  const AddCarViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCarCubit, AddCarState>(
      listener: (context, state) {
        if (state is AddCarSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.green,
            ),
          );
        } else if (state is AddCarError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = AddCarCubit.get(context);

        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: MyResponsive.width(value: 20),
              vertical: MyResponsive.height(value: 20),
            ),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MyResponsive.height(value: 10)),
                  // Images Section
                  _buildAnimatedField(
                    delay: 0,
                    child: _buildImagesSection(context, cubit, state),
                  ),
                  SizedBox(height: MyResponsive.height(value: 30)),

                  // Car Name Field
                  _buildAnimatedField(
                    delay: 100,
                    child: _buildTextField(
                      controller: cubit.nameController,
                      label: AppStrings.carName,
                      hint: AppStrings.carNameHint,
                      icon: Icons.directions_car,
                      validator: Validator.carName,
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 20)),

                  // City Dropdown Field
                  _buildAnimatedField(
                    delay: 200,
                    child: _buildCityDropdown(context, cubit),
                  ),
                  SizedBox(height: MyResponsive.height(value: 20)),

                  // Price Field
                  _buildAnimatedField(
                    delay: 300,
                    child: _buildTextField(
                      controller: cubit.priceController,
                      label: AppStrings.price,
                      hint: AppStrings.priceHint,
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: Validator.price,
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 20)),

                  // Phone Number Field
                  _buildAnimatedField(
                    delay: 300,
                    child: _buildTextField(
                      controller: cubit.phoneController,
                      label: AppStrings.phoneNumber,
                      hint: "01012345678",
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: Validator.phoneNumber,
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 20)),

                  // Description Field
                  _buildAnimatedField(
                    delay: 400,
                    child: _buildTextField(
                      controller: cubit.descriptionController,
                      label: AppStrings.description,
                      hint: AppStrings.descriptionHint,
                      icon: Icons.description,
                      maxLines: 5,
                      validator: Validator.description,
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 40)),

                  // Submit Button
                  _buildAnimatedField(
                    delay: 500,
                    child: state is AddCarLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF9D7FDB),
                            ),
                          )
                        : CustomButton(
                            title: AppStrings.submit,
                            onPressed: () => cubit.submitAd(),
                          ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 40)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Build Images Section
  Widget _buildImagesSection(
      BuildContext context, AddCarCubit cubit, AddCarState state) {
    return Container(
      padding: EdgeInsets.all(MyResponsive.width(value: 16)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 16)),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.add_photo_alternate, color: AppColors.white, size: 24),
              SizedBox(width: MyResponsive.width(value: 12)),
              Text(
                AppStrings.addImages,
                style:
                    AppTextStyles.semiBold17.copyWith(color: AppColors.white),
              ),
            ],
          ),
          SizedBox(height: MyResponsive.height(value: 16)),

          // Images Grid
          if (cubit.selectedImages.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: MyResponsive.width(value: 10),
                mainAxisSpacing: MyResponsive.height(value: 10),
              ),
              itemCount: cubit.selectedImages.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(MyResponsive.radius(value: 8)),
                      child: Image.file(
                        File(cubit.selectedImages[index].path),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => cubit.removeImage(index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.red,
                            shape: BoxShape.circle,
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

          if (cubit.selectedImages.isNotEmpty)
            SizedBox(height: MyResponsive.height(value: 16)),

          // Add Images Button
          GestureDetector(
            onTap:
                state is AddCarImagePicking ? null : () => cubit.pickImages(),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: MyResponsive.height(value: 16),
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius:
                    BorderRadius.circular(MyResponsive.radius(value: 10)),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: state is AddCarImagePicking
                  ? Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Color(0xFF9D7FDB),
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: AppColors.white),
                        SizedBox(width: MyResponsive.width(value: 8)),
                        Text(
                          cubit.selectedImages.isEmpty
                              ? AppStrings.addImages
                              : "إضافة المزيد من الصور",
                          style: AppTextStyles.semiBold14.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Build Text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: AppTextStyles.semiBold14.copyWith(color: AppColors.white),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: AppTextStyles.bold13.copyWith(color: Colors.grey[600]),
        hintStyle: AppTextStyles.bold13.copyWith(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        prefixIcon: Icon(icon, color: AppColors.gray),
        contentPadding: MyResponsive.paddingSymmetric(
          horizontal: 13,
          vertical: maxLines > 1 ? 20 : 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          borderSide: BorderSide(color: Color(0xFF9D7FDB), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          borderSide: BorderSide(color: Colors.red[400]!, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          borderSide: BorderSide(color: Colors.red[400]!, width: 1.5),
        ),
      ),
    );
  }

  // Animated Field Widget
  Widget _buildAnimatedField({
    required int delay,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildCityDropdown(BuildContext context, AddCarCubit cubit) {
    return DropdownButtonFormField<String>(
      value: cubit.selectedCity,
      decoration: InputDecoration(
        labelText: 'المدينة',
        hintText: 'اختر المدينة',
        labelStyle: AppTextStyles.bold13.copyWith(color: Colors.grey[600]),
        hintStyle: AppTextStyles.bold13.copyWith(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.primary),
        contentPadding: MyResponsive.paddingSymmetric(
          horizontal: 13,
          vertical: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          borderSide: BorderSide(color: Color(0xFF9D7FDB), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          borderSide: BorderSide(color: Colors.red[400]!, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          borderSide: BorderSide(color: Colors.red[400]!, width: 1.5),
        ),
      ),
      dropdownColor: const Color(0xFF1A1A2E),
      style: AppTextStyles.semiBold14.copyWith(color: AppColors.white),
      icon: Icon(Icons.arrow_drop_down, color: AppColors.gray),
      items: AddCarCubit.cities.map((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(
            city,
            style: AppTextStyles.semiBold14.copyWith(color: AppColors.white),
          ),
        );
      }).toList(),
      onChanged: (value) => cubit.changeCity(value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'من فضلك اختر المدينة';
        }
        return null;
      },
    );
  }
}
