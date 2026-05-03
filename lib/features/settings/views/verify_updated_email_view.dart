import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/network/api_helper.dart'; // تأكد من المسار
import 'package:dalilak_app/core/network/end_points.dart'; // تأكد من المسار
import 'package:dalilak_app/core/shared_widgets/custom_scaffold.dart';
import 'package:dalilak_app/features/auth/views/widgets/otp_widget.dart'; // 👈 ده مكان الويجت اللي انت بعتها
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class VerifyUpdatedEmailView extends StatefulWidget {
  final String email;
  const VerifyUpdatedEmailView({super.key, required this.email});

  @override
  State<VerifyUpdatedEmailView> createState() => _VerifyUpdatedEmailViewState();
}

class _VerifyUpdatedEmailViewState extends State<VerifyUpdatedEmailView> {
  String otpCode = '';
  bool isLoading = false;

  // دالة تفعيل الإيميل
  Future<void> verifyEmail() async {
    setState(() {
      isLoading = true;
    });

    try {
      // استدعاء الـ API مباشرة هنا للتبسيط
      // POST /api/Auth/verify-email
      await ApiHelper().postRequest(
        // 👇 التعديل هنا: استخدمنا المتغير الجاهز من كلاس EndPoints
        endPoint: EndPoints.verifyEmail,

        data: {
          "email": widget.email,
          "otpCode": otpCode,
        },
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("تم تحديث البريد الإلكتروني بنجاح"),
            backgroundColor: Colors.green),
      );

      // نرجع للصفحة اللي فاتت (البروفايل)
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      String errorMsg = "حدث خطأ ما";
      if (e is DioException) {
        errorMsg = e.response?.data['message'] ?? e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.only(top: MyResponsive.height(value: 50)),
              child: OtpWidget(
                // 👈 استخدام الويجت بتاعتك هنا
                isHaveImage: true,
                isOtpComplete: otpCode.length >= 4, // افترضت الكود 4 أرقام
                onOtpChanged: (value) {
                  setState(() {
                    otpCode = value;
                  });
                },
                onResendOtp: () {
                  // ممكن تضيف لوجيك إعادة الإرسال هنا
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("تم إعادة إرسال الرمز")),
                  );
                },
                onVerifyOtp: () {
                  verifyEmail();
                },
              ),
            ),
    );
  }
}
