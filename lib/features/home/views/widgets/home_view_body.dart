import 'package:dalilak_app/core/shared_widgets/used_cars_access_card.dart';
import 'package:dalilak_app/features/used_cars/views/used_cars_feed_view.dart';
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
            SizedBox(height: MyResponsive.height(value: 120)),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final cubit = context.read<HomeCubit>();
                  final messages = cubit.messages;

                  // عرض Skeleton عند تحميل الرسائل القديمة
                  if (state is HomeLoading && messages.isEmpty) {
                    return _buildLoadingSkeleton();
                  }

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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MyResponsive.height(value: 50)),
          Image.asset(AppAssets.chatImage),
          SizedBox(height: MyResponsive.height(value: 40)),
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
          SizedBox(height: MyResponsive.height(value: 40)),

          // UsedCarsAccessCard with smooth animation
          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 20),
            child: Builder(
              builder: (context) {
                return TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 800),
                  tween: Tween(begin: 0.0, end: 1.0),
                  curve: Curves.easeOutQuart,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: UsedCarsAccessCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UsedCarsFeedView(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: 3,
      separatorBuilder: (_, __) =>
          SizedBox(height: MyResponsive.height(value: 16)),
      itemBuilder: (_, index) {
        return Align(
          alignment: index.isEven
              ? AlignmentDirectional.centerStart
              : AlignmentDirectional.centerEnd,
          child: Container(
            width: MyResponsive.width(value: 250),
            height: MyResponsive.height(value: 60),
            decoration: BoxDecoration(
              color: const Color(0xFF2A1A4D).withOpacity(0.3),
              borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 12)),
            ),
            child: Center(
              child: SizedBox(
                width: MyResponsive.width(value: 20),
                height: MyResponsive.height(value: 20),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C5CE7)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
