import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_card.dart';
import '../../../product_details/data/models/product_model.dart';

class RandomProductsPage extends StatelessWidget {
  final List<ProductModel> products; // This is where the shuffled products will be received

  const RandomProductsPage({
    super.key,
    required this.products, // Make sure the constructor requires the products list
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar( // Using your CustomAppbar for consistency
        leftIcon: Icons.arrow_back_ios_new,
        titleText: 'New Arrivals', // Title for this page
        onLeftIconPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: AppColors.backgroundAppbar, // Consistent background color
      body: products.isEmpty
          ? const Center(
        child: Text('No new arrivals found.'), // Message if the list is empty
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: products.length, // Display all products in the received list
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7, // Adjust as needed for your card size
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return CustomCard(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.productDetails, arguments: product);
              },
              model: product,
            );
          },
        ),
      ),
    );
  }
}
