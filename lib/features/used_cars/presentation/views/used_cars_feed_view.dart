import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/add_car/views/add_car_view.dart';
import 'package:dalilak_app/features/used_cars/data/models/car_model.dart';
import 'package:dalilak_app/features/used_cars/presentation/views/car_details_view.dart';
import 'package:dalilak_app/features/used_cars/presentation/widgets/car_feed_item.dart';
import 'package:flutter/material.dart';

class UsedCarsFeedView extends StatefulWidget {
  const UsedCarsFeedView({super.key});

  @override
  State<UsedCarsFeedView> createState() => _UsedCarsFeedViewState();
}

class _UsedCarsFeedViewState extends State<UsedCarsFeedView> {
  final TextEditingController _searchController = TextEditingController();
  List<CarModel> _filteredCars = [];

  // Mock data
  final List<CarModel> _allCars = [
    CarModel(
      id: '1',
      name: 'BMW X5 2020',
      price: '450,000 ج.م',
      image: 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=500',
      location: 'القاهرة',
      year: '2020',
      description: 'سيارة في حالة ممتازة، استخدام شخصي، صيانة دورية',
    ),
    CarModel(
      id: '2',
      name: 'Hyundai Elantra 2021',
      price: '280,000 ج.م',
      image:
          'https://images.unsplash.com/photo-1619405399517-d7fce0f13302?w=500',
      location: 'الإسكندرية',
      year: '2021',
      description: 'حالة ممتازة، فحص كامل، بدون حوادث',
    ),
    CarModel(
      id: '3',
      name: 'Mercedes C200 2019',
      price: '520,000 ج.م',
      image:
          'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=500',
      location: 'الجيزة',
      year: '2019',
      description: 'فل أوبشن، حالة الزيرو، استيراد الخليج',
    ),
    CarModel(
      id: '4',
      name: 'Toyota Corolla 2022',
      price: '320,000 ج.م',
      image:
          'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=500',
      location: 'المنصورة',
      year: '2022',
      description: 'توكيل مصر، ضمان ساري، كيلومترات قليلة',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filteredCars = _allCars;
    _searchController.addListener(_filterCars);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCars() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCars = _allCars;
      } else {
        _filteredCars = _allCars
            .where((car) => car.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'سوق المستعمل',
          style: AppTextStyles.semiBold20.copyWith(color: AppColors.white),
        ),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: MyResponsive.paddingSymmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: MyResponsive.height(value: 20)),

              // Sleek Search Field
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius:
                      BorderRadius.circular(MyResponsive.radius(value: 15)),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'ابحث عن سيارة...',
                    hintStyle: AppTextStyles.regular14.copyWith(
                      color: AppColors.gray,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.gray,
                      size: 24,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MyResponsive.height(value: 14),
                      horizontal: MyResponsive.width(value: 20),
                    ),
                  ),
                ),
              ),

              SizedBox(height: MyResponsive.height(value: 24)),

              // Cars List with bottom padding for FAB
              Expanded(
                child: _filteredCars.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: AppColors.gray,
                            ),
                            SizedBox(height: MyResponsive.height(value: 16)),
                            Text(
                              'لا توجد نتائج',
                              style: AppTextStyles.semiBold16.copyWith(
                                color: AppColors.gray,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.only(
                          bottom: MyResponsive.height(value: 80),
                        ),
                        itemCount: _filteredCars.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: MyResponsive.height(value: 20)),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CarDetailsView(
                                    car: _filteredCars[index],
                                  ),
                                ),
                              );
                            },
                            child: CarFeedItem(car: _filteredCars[index]),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCarView(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
        label: Text(
          'بيع سيارتك',
          style: AppTextStyles.semiBold14.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
