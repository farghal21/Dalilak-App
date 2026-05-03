import 'package:get/get.dart';

abstract class MyNavigator {
  static goTo({
    required Function screen, // تغيير من dynamic إلى Function
    bool isReplace = false,
    Transition transition = Transition.rightToLeftWithFade,
    Duration? duration,
  }) {
    if (isReplace) {
      Get.offAll(
        screen, // GetX سيستدعي الـ Function تلقائياً
        transition: transition,
        duration: duration ?? Duration(milliseconds: 300),
      );
    } else {
      Get.to(
        screen, // GetX سيستدعي الـ Function تلقائياً
        transition: transition,
        duration: duration ?? Duration(milliseconds: 300),
      );
    }
  }

  static goBackUntil({
    required dynamic screen,
    Transition transition = Transition.rightToLeftWithFade,
    Duration? duration,
  }) {
    Get.offUntil(
      screen,
      (route) => false,
    );
  }

  static pop() {
    Get.back();
  }
}
