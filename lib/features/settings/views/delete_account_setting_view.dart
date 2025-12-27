import 'package:dalilak_app/features/auth/data/repo/auth_repo.dart'
    show AuthRepo;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Imports للـ Widgets والـ Cubit
import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import 'widgets/delete_account_setting_view_body.dart';
import '../manager/delete_account_setting_cubit/delete_account_setting_cubit.dart';
import '../manager/delete_account_setting_cubit/delete_account_setting_state.dart';
import 'delete_account_done_view.dart';

// --- Imports جديدة ومهمة جداً (عشان الحقن يشتغل) ---
import '../../../../core/helper/get_it.dart';

class DeleteAccountSettingView extends StatelessWidget {
  const DeleteAccountSettingView({super.key});

  static const String routeName = 'DeleteAccountView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // التعديل هنا: استخدام getIt لتمرير الـ AuthRepo
      create: (context) => DeleteAccountSettingCubit(getIt<AuthRepo>()),
      child: CustomScaffold(
        isHomeScreen: true,
        showDrawer: false,
        drawerSelectedIndex: 4,
        body:
            BlocConsumer<DeleteAccountSettingCubit, DeleteAccountSettingState>(
          listener: (context, state) {
            if (state is DeleteAccountSettingSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, DeleteAccountDoneView.routeName, (route) => false);
            }
            if (state is DeleteAccountSettingError) {
              // يفضل إظهار رسالة خطأ هنا لو حصلت مشكلة
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.errMessage),
                    backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            return CustomProgressHud(
              isLoading: state is DeleteAccountSettingLoading,
              child: const DeleteAccountSettingViewBody(),
            );
          },
        ),
      ),
    );
  }
}
