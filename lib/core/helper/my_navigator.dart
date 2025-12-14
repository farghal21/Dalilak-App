import 'package:get/get.dart';

abstract class MyNavigator {
  static goTo({
    required screen,
    bool isReplace = false,
    Transition transition = Transition.rightToLeftWithFade,
    Duration? duration,
  }) {
    if (isReplace) {
      Get.offAll(
        screen,
        transition: transition,
        duration: duration ?? Duration(milliseconds: 300),
      );
    } else {
      Get.to(
        screen,
        transition: transition,
        duration: duration ?? Duration(milliseconds: 300),
      );
    }
  }

  static goBackUntil({
    required screen,
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
