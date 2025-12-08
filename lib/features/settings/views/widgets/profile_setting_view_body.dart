import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../../core/shared_widgets/image_manager/image_manager_view.dart';
import '../../../../core/shared_widgets/profile_image_widget.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/profile_cubit/profile_cubit.dart';

class ProfileSettingViewBody extends StatelessWidget {
  const ProfileSettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ProfileCubit.get(context);
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MyResponsive.height(value: 110),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                AppStrings.profile,
                style: AppTextStyles.semiBold24,
              ),
            ),
            SizedBox(
              height: MyResponsive.height(value: 42),
            ),
            Stack(
              children: [
                ImageManagerView(
                  cubit: cubit.imageCubit,
                  onPicked: (XFile imageFile) {
                    cubit.imageFile = imageFile;
                  },
                  pickedBody: (XFile imageFile) {
                    return ProfileImageWidget(
                      imagePath: imageFile.path,
                      isLocalFile: true,
                      width: MyResponsive.width(value: 126),
                    );
                  },
                  unPickedBody: ProfileImageWidget(
                    imagePath: null,
                    width: MyResponsive.width(value: 126),
                  ),
                ),
                PositionedDirectional(
                  bottom: 0,
                  end: 0,
                  child: SvgWrapper(
                    path: AppAssets.cameraIcon,
                    width: MyResponsive.width(value: 35),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MyResponsive.height(value: 4),
            ),
            Text(
              AppStrings.userName,
              style: AppTextStyles.semiBold24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ID: 3309449812',
                  style:
                      AppTextStyles.semiBold20.copyWith(color: AppColors.gray),
                ),
                IconButton(
                  onPressed: cubit.copyUserId,
                  icon: SvgWrapper(
                    path: AppAssets.copyIcon,
                    color: AppColors.gray,
                    width: MyResponsive.width(value: 24),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MyResponsive.height(value: 12),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: AppStrings.updateImage,
                    onPressed: cubit.updateImage,
                  ),
                ),
                SizedBox(
                  width: MyResponsive.width(value: 27),
                ),
                Expanded(
                  child: CustomButton(
                    title: AppStrings.deleteImage,
                    onPressed: cubit.deleteImage,
                    backgroundColor: AppColors.fillColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MyResponsive.height(value: 20),
            ),
            CustomTextFormField(
              type: TextFieldType.name,
              controller: cubit.nameController,
            ),
            SizedBox(
              height: MyResponsive.height(value: 20),
            ),
            CustomTextFormField(
              type: TextFieldType.email,
              controller: cubit.emailController,
            ),
            SizedBox(
              height: MyResponsive.height(value: 20),
            ),
            // CustomTextFormField(
            //   type: TextFieldType.phone,
            //   controller: cubit.phoneController,
            // ),
            // SizedBox(
            //   height: MyResponsive.height(value: 140),
            // ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: AppStrings.save,
                    onPressed: cubit.saveProfileData,
                  ),
                ),
                SizedBox(
                  width: MyResponsive.width(value: 29),
                ),
                Expanded(
                  child: CustomButton(
                    title: AppStrings.cancel,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: AppColors.fillColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MyResponsive.height(value: 20),
            )
          ],
        ),
      ),
    );
  }
}
