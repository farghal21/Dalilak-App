import 'package:dalilak_app/features/home/views/widgets/text_message_widget.dart';
import 'package:dalilak_app/features/home/views/widgets/with_media_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../data/models/message_model.dart';
import '../../manager/home_cubit/home_cubit.dart';
import '../../manager/home_cubit/home_state.dart';
import 'category_list_view_item.dart';
import 'chat_error_widget.dart';
import 'chat_loading_widget.dart';
import 'chat_text_field.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: MyResponsive.paddingSymmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: MyResponsive.height(value: 100)),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final cubit = context.read<HomeCubit>();
                  final messages = cubit.messages;

                  if (messages.isEmpty) return _buildEmptyState(cubit);

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    controller: cubit.scrollController,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isUser = message.sender == MessageSender.user;

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        switchInCurve: Curves.easeOutBack,
                        transitionBuilder: (child, animation) {
                          final offsetAnimation = Tween<Offset>(
                            begin: Offset(isUser ? 1.0 : -1.0, 0),
                            end: Offset.zero,
                          ).animate(animation);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: Align(
                          key: ValueKey(message),
                          alignment: isUser
                              ? AlignmentDirectional.centerEnd
                              : AlignmentDirectional.centerStart,
                          child: () {
                            switch (message.messageType) {
                              case MessageType.loading:
                                return const ChatLoadingWidget();

                              case MessageType.error:
                                return ChatErrorWidget(
                                  errorMessage: message.message,
                                  onRetry: () {
                                    final lastUserMessage = messages
                                        .lastWhere((m) =>
                                            m.sender == MessageSender.user)
                                        .message;

                                    cubit.sendUserMessage(lastUserMessage);
                                  },
                                );

                              case MessageType.hasData:
                                return WithMediaMessageWidget(message: message);

                              case MessageType.text:
                              default:
                                return TextMessageWidget(message: message);
                            }
                          }(),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: MyResponsive.height(value: 16)),
                    itemCount: messages.length,
                  );
                },
              ),
            ),
            SizedBox(height: MyResponsive.height(value: 10)),
            ChatTextField(
              onSend: (text) => cubit.sendUserMessage(text),
            ),
            SizedBox(height: MyResponsive.height(value: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(HomeCubit cubit) {
    final categories = [
      {
        'title': AppStrings.recommendCar,
        'subtitle': AppStrings.recommendCarSubtitle,
        'iconPath': AppAssets.dateImage,
      },
      {
        'title': AppStrings.cost,
        'subtitle': AppStrings.costSubtitle,
        'iconPath': AppAssets.orderImage,
      },
      {
        'title': AppStrings.compareCars,
        'subtitle': AppStrings.compareCarsSubtitle,
        'iconPath': AppAssets.shopImage,
      },
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MyResponsive.height(value: 72)),
          Image.asset(AppAssets.chatImage),
          SizedBox(height: MyResponsive.height(value: 22)),
          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 14),
            child: Text(
              AppStrings.homeWelcome,
              style: AppTextStyles.semiBold21.copyWith(
                height: MyResponsive.height(value: 1.9),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: MyResponsive.height(value: 27)),
          SizedBox(
            height: MyResponsive.height(value: 175),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () => cubit.sendUserMessage(category['title']!),
                  child: CategoryListViewItem(
                    title: category['title']!,
                    subtitle: category['subtitle']!,
                    // iconPath: category['iconPath']!,
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(width: MyResponsive.width(value: 20)),
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
