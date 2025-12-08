import 'package:flutter/material.dart';
import '../helper/my_responsive.dart';
import '../utils/app_colors.dart';

class AppLoading extends StatefulWidget {
  const AppLoading({super.key});

  @override
  State<AppLoading> createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];
  final int _waveCount = 5;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _waveCount; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600 + i * 120),
      );
      final animation = Tween<double>(begin: 20, end: 82).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
      _controllers.add(controller);
      _animations.add(animation);
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) controller.repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_waveCount, (i) {
          return AnimatedBuilder(
            animation: _animations[i],
            builder: (context, _) {
              return Container(
                margin: MyResponsive.paddingSymmetric(horizontal: 7.5),
                width: MyResponsive.width(value: 12.5),
                height: MyResponsive.height(value: _animations[i].value),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 12)),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
