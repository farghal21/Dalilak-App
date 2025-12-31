import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalilak_app/core/helper/get_it.dart';
import 'package:dalilak_app/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:dalilak_app/core/shared_widgets/custom_scaffold.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/features/used_cars/data/models/car_model.dart';
import 'package:dalilak_app/features/used_cars/manager/used_cars_cubit/used_cars_cubit.dart';
import 'package:dalilak_app/features/used_cars/views/add_car_view.dart';
import 'package:dalilak_app/features/used_cars/views/car_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// UsedCarsFeedView - Displays list of used cars from backend API
/// Uses BlocBuilder to handle different states (Loading, Loaded, Failure)
class UsedCarsFeedView extends StatelessWidget {
  const UsedCarsFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UsedCarsCubit>()..getAllCars(),
      child: CustomScaffold(
        drawerSelectedIndex: 6,
        isHomeScreen: true,
        appBar: AppBar(
          title: Text(
            'السيارات المستعملة',
            style: AppTextStyles.semiBold20.copyWith(color: AppColors.white),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: AppColors.horizontalGradient,
            ),
          ),
          iconTheme: IconThemeData(color: AppColors.white),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddCarView(),
                  ),
                );
                if (result == true && context.mounted) {
                  // Refresh the list after adding a car
                  context.read<UsedCarsCubit>().refreshCars();
                }
              },
            ),
          ],
        ),
        body: const UsedCarsFeedViewBody(),
      ),
    );
  }
}

class UsedCarsFeedViewBody extends StatefulWidget {
  const UsedCarsFeedViewBody({super.key});

  @override
  State<UsedCarsFeedViewBody> createState() => _UsedCarsFeedViewBodyState();
}

class _UsedCarsFeedViewBodyState extends State<UsedCarsFeedViewBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Handle scroll to load more cars when reaching the bottom
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final cubit = context.read<UsedCarsCubit>();
      if (cubit.hasMorePages) {
        cubit.loadMoreCars();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsedCarsCubit, UsedCarsState>(
      builder: (context, state) {
        // Handle Loading State
        if (state is UsedCarsLoading) {
          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'جاري تحميل السيارات...',
                    style: AppTextStyles.semiBold16.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Handle Failure State
        if (state is UsedCarsFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.error_outline_rounded,
                      size: 60,
                      color: Colors.red.shade400,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'حدث خطأ',
                    style: AppTextStyles.semiBold20.copyWith(
                      color: Colors.red.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      state.error,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.regular14.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<UsedCarsCubit>().getAllCars();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appFill,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.refresh_rounded, size: 24),
                    label: Text(
                      'إعادة المحاولة',
                      style: AppTextStyles.semiBold16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Handle Loaded State (including LoadingMoreCars)
        if (state is UsedCarsLoaded || state is LoadingMoreCars) {
          final cars = state is UsedCarsLoaded
              ? state.cars
              : (state as LoadingMoreCars).currentCars;

          if (cars.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary.withValues(alpha: 0.1),
                            AppColors.primary.withValues(alpha: 0.05),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.directions_car_outlined,
                        size: 60,
                        color: AppColors.primary.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'لا توجد سيارات متاحة',
                      style: AppTextStyles.semiBold20.copyWith(
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'كن أول من يضيف سيارة',
                      style: AppTextStyles.regular16.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddCarView(),
                          ),
                        );
                        if (result == true && context.mounted) {
                          context.read<UsedCarsCubit>().refreshCars();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.appFill,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.add_circle_outline, size: 24),
                      label: Text(
                        'إضافة سيارة',
                        style: AppTextStyles.semiBold16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final isLoadingMore = state is LoadingMoreCars;

          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<UsedCarsCubit>().refreshCars();
              },
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 16),
                itemCount: cars.length + (isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  // Loading indicator at the bottom
                  if (index == cars.length) {
                    return const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final car = cars[index];
                  return CarItemWidget(
                    car: car,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CarDetailsView(car: car),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        }

        // Default empty state
        return const SizedBox();
      },
    );
  }
}

/// CarItemWidget - Displays a single car with image carousel
/// Shows image slider, name, price, city, and year
class CarItemWidget extends StatefulWidget {
  final CarModel car;
  final VoidCallback onTap;

  const CarItemWidget({
    super.key,
    required this.car,
    required this.onTap,
  });

  @override
  State<CarItemWidget> createState() => _CarItemWidgetState();
}

class _CarItemWidgetState extends State<CarItemWidget> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsets.only(bottom: MyResponsive.height(value: 16)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1B0034),
              Color(0xFF2D1B4E),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.white.withValues(alpha: .08),
            width: MyResponsive.width(value: 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: .4),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel Section
              _buildImageCarousel(),

              // Car Details Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car Name - Primary Text
                    Text(
                      widget.car.name,
                      style: AppTextStyles.bold20.copyWith(
                        color: AppColors.white,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: MyResponsive.height(value: 12)),

                    // Price Badge - Gradient Style
                    Container(
                      padding: MyResponsive.paddingSymmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withValues(alpha: .15),
                            AppColors.secondary.withValues(alpha: .15),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                          MyResponsive.radius(value: 12),
                        ),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: .3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '${_formatPrice(widget.car.price)} ج.م',
                        style: AppTextStyles.semiBold15.copyWith(
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: MyResponsive.height(value: 12)),

                    // City and Year - Glassmorphism Style
                    Row(
                      children: [
                        // City Container
                        Expanded(
                          child: _buildInfoItem(
                            icon: Icons.location_on_rounded,
                            label: widget.car.city,
                          ),
                        ),
                        SizedBox(width: MyResponsive.width(value: 12)),
                        // Year Container
                        Expanded(
                          child: _buildInfoItem(
                            icon: Icons.calendar_today_rounded,
                            label: '${widget.car.createdAtYear}',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    // Handle no images case
    if (widget.car.images.isEmpty) {
      return _buildPlaceholderImage();
    }

    // Single image - no carousel needed (conditional logic)
    if (widget.car.images.length <= 1) {
      return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 180,
          child: CachedNetworkImageWrapper(
            imagePath: widget.car.images.first,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // Multiple images - use carousel with dots indicator
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: CarouselSlider.builder(
            itemCount: widget.car.images.length,
            itemBuilder: (context, index, realIndex) {
              return SizedBox(
                width: double.infinity,
                child: CachedNetworkImageWrapper(
                  imagePath: widget.car.images[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              height: 180,
              viewportFraction: 1.0,
              autoPlay: false,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
          ),
        ),
        // Dots Indicator (only for multiple images)
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: _currentImageIndex,
              count: widget.car.images.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: AppColors.primary,
                dotColor: Colors.white.withValues(alpha: 0.7),
                expansionFactor: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.black.withValues(alpha: .6),
            AppColors.black.withValues(alpha: .8),
          ],
        ),
      ),
      child: Icon(
        Icons.directions_car_outlined,
        size: 80,
        color: AppColors.white.withValues(alpha: .5),
      ),
    );
  }

  /// Glassmorphism info item widget
  Widget _buildInfoItem({required IconData icon, required String label}) {
    return Container(
      padding: MyResponsive.paddingSymmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        border: Border.all(
          color: AppColors.white.withValues(alpha: .1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.white.withValues(alpha: .7),
            size: MyResponsive.fontSize(value: 16),
          ),
          SizedBox(width: MyResponsive.width(value: 8)),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.regular12.copyWith(
                color: AppColors.white.withValues(alpha: .85),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Format price with thousand separators
  String _formatPrice(double price) {
    final priceStr = price.toStringAsFixed(0);
    final reversed = priceStr.split('').reversed.toList();
    final formatted = <String>[];

    for (int i = 0; i < reversed.length; i++) {
      if (i > 0 && i % 3 == 0) {
        formatted.add(',');
      }
      formatted.add(reversed[i]);
    }

    return formatted.reversed.join();
  }
}
