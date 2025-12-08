import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, this.onSend});

  final Function(String)? onSend;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController _controller = TextEditingController();
  TextDirection? _textDirection;

  void _onTextChanged(String text) {
    if (text.trim().isEmpty) {
      if (_textDirection != null) setState(() => _textDirection = null);
      return;
    }

    final firstChar = text.trimLeft().characters.first;
    final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(firstChar);
    final newDir = isArabic ? TextDirection.rtl : TextDirection.ltr;

    if (newDir != _textDirection) setState(() => _textDirection = newDir);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyResponsive.paddingSymmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 15)),
        border:
            Border.all(color: AppColors.white.withValues(alpha: .1), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _onTextChanged,
              textDirection: _textDirection,
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                hintText: AppStrings.chatHint,
                hintStyle:
                    AppTextStyles.regular16.copyWith(color: AppColors.gray),
                border: InputBorder.none,
                // isDense: true,
                contentPadding: MyResponsive.paddingSymmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
              ),
            ),
          ),
          SizedBox(width: MyResponsive.width(value: 4)),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.mic_none,
          //     color: AppColors.white.withValues(alpha: .5),
          //     size: MyResponsive.fontSize(value: 30),
          //   ),
          // ),

          IconButton(
            onPressed: () {
              final text = _controller.text.trim();
              if (text.isEmpty) return;
              widget.onSend?.call(text);
              _controller.clear();
              setState(() => _textDirection = null);
            },
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xff1B1929),
              padding: MyResponsive.paddingAll(value: 12),
            ),
            icon: Icon(
              Icons.send_rounded,
              color: AppColors.white.withValues(alpha: .5),
              size: MyResponsive.fontSize(value: 28),
            ),
          ),
        ],
      ),
    );
  }
}
