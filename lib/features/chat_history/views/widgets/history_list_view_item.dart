import 'package:dalilak_app/core/helper/my_navigator.dart';
import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/chat_history/data/models/get_chat_history_response_model.dart';
import 'package:dalilak_app/features/chat_history/manager/history_cubit/history_cubit.dart';
import 'package:dalilak_app/features/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryListViewItem extends StatelessWidget {
  HistoryListViewItem({
    super.key,
    required this.item,
  });

  Sessions item;

  @override
  Widget build(BuildContext context) {
    var formattedDate = formatDateTime(item.createdAt ?? '');
    return InkWell(
      onTap: () {
        MyNavigator.goTo(screen: HomeView(), isReplace: true);
      },
      child: Container(
        width: double.infinity,
        padding: MyResponsive.paddingSymmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name ?? '',
              style: AppTextStyles.bold20,
            ),
            SizedBox(
              height: MyResponsive.height(value: 6),
            ),
            Text(
              formattedDate,
              style: AppTextStyles.regular14.copyWith(color: AppColors.gray),
            ),
            SizedBox(
              height: MyResponsive.height(value: 14),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showRenameDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        MyResponsive.radius(value: 8),
                      ),
                    ),
                    backgroundColor: Color(0xFF4A3771),
                  ),
                  child: Text(
                    AppStrings.rename,
                    style: AppTextStyles.regular11
                        .copyWith(color: AppColors.white),
                  ),
                ),
                SizedBox(
                  width: MyResponsive.width(value: 10),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        MyResponsive.radius(value: 8),
                      ),
                    ),
                    backgroundColor: AppColors.red,
                  ),
                  child: Text(
                    AppStrings.remove,
                    style: AppTextStyles.regular11
                        .copyWith(color: AppColors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String formatDateTime(String isoDate) {
    final dateTime = DateTime.parse(isoDate);

    final date = DateFormat('dd/MM/yyyy').format(dateTime);
    final time = DateFormat('hh:mm a').format(dateTime);

    return 'تم الإنشاء $date - $time';
  }

  void _showRenameDialog(BuildContext context) {
    final controller = TextEditingController();
    final cubit = HistoryCubit.get(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF220F49),
          title: Text(
            'إعادة تسمية المحادثة',
            // style: AppTextStyles.semiBold17
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'اكتب الاسم الجديد',
              filled: true,
              fillColor: AppColors.fillColor,
              border: _border(context, AppColors.white),
              focusedErrorBorder: _border(context, AppColors.red),
              focusedBorder: _border(context, AppColors.primary),
              enabledBorder: _border(context, AppColors.white),
              errorBorder: _border(context, AppColors.red),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                final newName = controller.text.trim();
                if (newName.isEmpty) return;

                cubit.renameSession(
                  newName: newName,
                  sessionId: item.id!,
                );

                Navigator.pop(context);
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final cubit = HistoryCubit.get(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('تحذير'),
          content: const Text('هل أنت متأكد أنك تريد حذف هذه المحادثة؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                cubit.deleteSession(
                  item.id!,
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
              ),
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  InputBorder _border(BuildContext context, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(MyResponsive.radius(value: 10)),
      ),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
