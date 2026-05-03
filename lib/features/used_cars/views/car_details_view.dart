import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/shared_widgets/custom_scaffold.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/used_cars/data/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CarDetailsView extends StatelessWidget {
  const CarDetailsView({
    super.key,
    required this.car,
  });

  final CarModel car;

  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      // Sanitize: keep only digits and +
      final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

      // Simple URI parsing
      final url = Uri.parse("tel:$cleanNumber");

      // Launch with default behavior (safest for dialer intent)
      await launchUrl(url);
    } catch (e) {
      // Log error if launch fails
      debugPrint('Failed to launch phone dialer: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      drawerSelectedIndex: 7,
      isHomeScreen: false,
      body: Stack(
        children: [
          // Layer 1: Car Image (Top 50%)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.50,
            child: Image.network(
              car.images.isNotEmpty ? car.images.first : '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF2A2A3E),
                  child: Center(
                    child: Icon(
                      Icons.directions_car_outlined,
                      size: 80,
                      color: Colors.grey[700],
                    ),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: const Color(0xFF2A2A3E),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),

          // Layer 2: Details Sheet (Bottom 55%)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MyResponsive.radius(value: 40)),
                  topRight: Radius.circular(MyResponsive.radius(value: 40)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 30,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Top Indicator (Knob)
                  SizedBox(height: MyResponsive.height(value: 12)),
                  Container(
                    width: MyResponsive.width(value: 40),
                    height: MyResponsive.height(value: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 20)),

                  // Content Area (Scrollable)
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: MyResponsive.width(value: 24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header: Car Name and Price
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  car.name,
                                  style: AppTextStyles.semiBold21.copyWith(
                                    color: AppColors.white,
                                    height: 1.3,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: MyResponsive.width(value: 16)),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MyResponsive.width(value: 16),
                                  vertical: MyResponsive.height(value: 8),
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(
                                    MyResponsive.radius(value: 12),
                                  ),
                                ),
                                child: Text(
                                  car.price.toString(),
                                  style: AppTextStyles.bold18.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: MyResponsive.height(value: 24)),

                          // Specs: Location and Year
                          Row(
                            children: [
                              Expanded(
                                child: _buildSpecItem(
                                  icon: Icons.location_on_outlined,
                                  label: 'الموقع',
                                  value: car.city,
                                ),
                              ),
                              SizedBox(width: MyResponsive.width(value: 16)),
                              Expanded(
                                child: _buildSpecItem(
                                  icon: Icons.calendar_today_outlined,
                                  label: 'السنة',
                                  value: car.createdAtYear.toString(),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: MyResponsive.height(value: 24)),

                          // Description Section
                          Text(
                            'الوصف',
                            style: AppTextStyles.bold18.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(height: MyResponsive.height(value: 12)),
                          Text(
                            car.description,
                            style: AppTextStyles.regular16.copyWith(
                              color: AppColors.gray,
                              height: 1.6,
                            ),
                          ),

                          SizedBox(height: MyResponsive.height(value: 24)),
                        ],
                      ),
                    ),
                  ),

                  // Action Button
                  Padding(
                    padding: EdgeInsets.all(MyResponsive.width(value: 24)),
                    child: SizedBox(
                      width: double.infinity,
                      height: MyResponsive.height(value: 56),
                      child: ElevatedButton.icon(
                        onPressed: () => _makePhoneCall(car.buyerPhoneNumber),
                        icon: const Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                        label: Text(
                          'تواصل مع البائع',
                          style: AppTextStyles.bold16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyResponsive.radius(value: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(MyResponsive.width(value: 16)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 12)),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: AppColors.primary,
              ),
              SizedBox(width: MyResponsive.width(value: 8)),
              Text(
                label,
                style: AppTextStyles.regular12.copyWith(
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
          SizedBox(height: MyResponsive.height(value: 8)),
          Text(
            value,
            style: AppTextStyles.semiBold16.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
