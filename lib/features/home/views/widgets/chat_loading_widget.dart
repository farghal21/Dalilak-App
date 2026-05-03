import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class ChatLoadingWidget extends StatelessWidget {
  const ChatLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppAssets.chatImage,
          width: MyResponsive.width(value: 57),
          fit: BoxFit.fill,
        ),
        SizedBox(width: MyResponsive.width(value: 8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.chatLoadingTitle,
                style: AppTextStyles.bold20,
              ),
              SizedBox(height: MyResponsive.height(value: 4)),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.chatLoadingSubTitle,
                      style: AppTextStyles.regular16,
                    ),
                  ),
                  // Lottie typing animation
                  Lottie.network(
                    'https://lottie.host/embed/b7f3e3e0-5e0a-4e3a-8e3a-5e0a4e3a8e3a/typing-dots.json',
                    width: MyResponsive.width(value: 40),
                    height: MyResponsive.height(value: 40),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to simple animated dots
                      return _AnimatedDots();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Fallback animated dots widget
class _AnimatedDots extends StatefulWidget {
  const _AnimatedDots();

  @override
  State<_AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<_AnimatedDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyResponsive.width(value: 40),
      height: MyResponsive.height(value: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final delay = index * 0.2;
              final value = (_controller.value - delay) % 1.0;
              final opacity = value < 0.5 ? (value * 2) : (2 - value * 2);

              return Opacity(
                opacity: opacity.clamp(0.3, 1.0),
                child: Container(
                  width: 6,
                  height: 6,
                  margin: EdgeInsets.symmetric(
                    horizontal: MyResponsive.width(value: 2),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
