import 'package:final_project/core/constants/colors.dart';
import 'package:final_project/core/widgets/custom_appbar.dart';
import 'package:final_project/core/widgets/custom_card.dart';
import 'package:final_project/core/widgets/custom_text.dart';
import 'package:final_project/core/widgets/custom_text_field.dart';
import 'package:final_project/features/product_details/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/brand_list_item.dart';
import '../../../../core/widgets/custom_navigation_bar.dart';
import '../../data/models/brand_model.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navBarSelectedIndex = 0;

  void _onNavBarItemTapped(int index) {
    setState(() {
      _navBarSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppbar(
          rightIcon: Icons.shopping_bag_outlined,
          leftIcon: Icons.apps,
          titleText: 'Mondolibug, Sylhet',
          showLocation: true,
        ),
        backgroundColor: AppColors.backgroundAppbar,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            if (state is HomeLoaded) {
              final popularProducts = state.filteredProducts;
              final displayedPopularProducts = popularProducts.sublist(0, min(4, popularProducts.length));
              final newArrivals = state.newArrivals;
              final randomProduct = newArrivals.isNotEmpty ? newArrivals.first : ProductModel.empty();

              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth > 600 ? 32.0 : 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          CustomTextField(
                            text: 'Looking for shoes',
                            onChanged: (query) {
                              context.read<HomeCubit>().searchProducts(query);
                            },
                          ),
                          const SizedBox(height: 30),
                          if (state.searchQuery.isEmpty)
                            SizedBox(
                              height: 55,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: BrandModels.length,
                                itemBuilder: (context, index) {
                                  final brandModel = BrandModels[index];
                                  final isSelected = state.brandSelectedIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      context.read<HomeCubit>().selectBrand(index);
                                    },
                                    child: BrandListItem(
                                      brand: brandModel,
                                      isSelected: isSelected,
                                    ),
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: state.searchQuery.isEmpty ? 'Popular Shoes' : 'Search Results',
                                fontSize: 18,
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              if (state.searchQuery.isEmpty)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.brandProducts,
                                      arguments: {
                                        'brand': BrandModels[state.brandSelectedIndex].name,
                                        // Pass the *full* list of products to the "See all" page
                                        'products': popularProducts,
                                      },
                                    );
                                  },
                                  child: const CustomText(
                                    text: 'See all',
                                    fontSize: 16,
                                    color: AppColors.lightBlue,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (popularProducts.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text("No shoes found."),
                              ),
                            )
                          else
                            SizedBox(
                              height: 220,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: displayedPopularProducts.length,
                                separatorBuilder: (_, __) => const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final product = displayedPopularProducts[index];
                                  return CustomCard(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.productDetails,
                                        arguments: product,
                                      );
                                    },
                                    model: product,
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 20),
                          if (state.searchQuery.isEmpty) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: 'New Arrivals',
                                  fontSize: 18,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.randomProducts,
                                      arguments: newArrivals,
                                    );
                                  },
                                  child: const CustomText(
                                    text: 'See all',
                                    fontSize: 16,
                                    color: AppColors.lightBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            if (randomProduct != ProductModel.empty())
                              _buildNewArrivalsCard(randomProduct, constraints),
                          ],
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _navBarSelectedIndex,
          onItemTapped: _onNavBarItemTapped,
        ),
      ),
    );
  }

  Widget _buildNewArrivalsCard(ProductModel product, BoxConstraints constraints) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.productDetails,
          arguments: product,
        );
      },
      child: Container(
        width: double.infinity,
        height: constraints.maxWidth > 600 ? 200 : 150,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Best Choice',
                      fontSize: 16,
                      color: AppColors.lightBlue,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      text: product.name,
                      fontSize: 20,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      text: '\$${product.price}',
                      fontSize: 18,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
