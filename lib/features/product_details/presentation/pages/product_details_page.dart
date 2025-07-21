import 'package:final_project/core/widgets/custom_appbar.dart';
import 'package:final_project/core/widgets/custom_button.dart';
import 'package:final_project/core/widgets/custom_text.dart';
import 'package:final_project/core/widgets/gallery_container.dart';
import 'package:final_project/core/widgets/sizes_container.dart';
import 'package:final_project/features/product_details/data/models/sizes_model.dart';
import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.initialProduct});

  final ProductModel initialProduct;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _selectedGalleryIndex = 0;
  int _selectedSizeIndex = 0;

  late ProductModel selectedProduct;

  @override
  void initState() {
    super.initState();
    selectedProduct = widget.initialProduct;
  }

  @override
  Widget build(BuildContext context) {
    List<String> galleryImages = [
      selectedProduct.image,
      selectedProduct.image,
      selectedProduct.image,
    ];
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          rightIcon: const Icon(Icons.shopping_bag_outlined),
          leftIcon: Icons.arrow_back_ios_new,
          titleText: 'Men’s Shoes',
          onLeftIconPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 600;
            if (isWide) {
              return _buildWideLayout(galleryImages);
            } else {
              return _buildNarrowLayout(galleryImages);
            }
          },
        ),
      ),
    );
  }

  Widget _buildNarrowLayout(List<String> galleryImages) {
    return Column(
      children: [
        _buildProductImage(),
        const SizedBox(height: 20),
        Expanded(child: _buildProductInfo(galleryImages)),
      ],
    );
  }

  Widget _buildWideLayout(List<String> galleryImages) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildProductImage(),
            ),
          ),
        ),
        Expanded(flex: 1, child: _buildProductInfo(galleryImages)),
      ],
    );
  }

  Widget _buildProductImage() {
    final theme = Theme.of(context);
    return Container(
      height: 300,
      color: theme.scaffoldBackgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                if (theme.brightness == Brightness.light)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                selectedProduct.image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: CustomText(text: 'Image Not Found'),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            child: Image.asset(
              'assets/icons/circle.png',
              width: 250,
              color: theme.brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.1)
                  : null,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(List<String> galleryImages) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Best Seller',
                fontSize: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 8),
              CustomText(
                text: selectedProduct.name,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: '\$${selectedProduct.price}',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 15),
              CustomText(
                text: selectedProduct.description,
                fontSize: 16,
              ),
              const SizedBox(height: 20),
              const CustomText(
                text: 'Gallery',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: galleryImages.length,
                  itemBuilder: (context, index) {
                    final imageUrl = galleryImages[index];
                    final isSelected = _selectedGalleryIndex == index;
                    return GalleryContainer(
                      imageUrl: imageUrl,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedGalleryIndex = index;
                        });
                      }, productModel: null,
                    );
                  },
                  separatorBuilder: (context, index) =>
                  const SizedBox(width: 15),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Size',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: const [
                      CustomText(
                        text: 'EU',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'US',
                        fontSize: 18,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'UK',
                        fontSize: 18,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: List.generate(SizesModel.sizes.length, (index) {
                  final size = SizesModel.sizes[index];
                  final isSelected = _selectedSizeIndex == index;
                  return SizesContainer(
                    sizesModel: size,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedSizeIndex = index;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Price',
                        fontSize: 16,
                      ),
                      const SizedBox(height: 5),
                      CustomText(
                        text: '\$${selectedProduct.price}',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {},
                      child: const CustomText(
                        text: 'Add To Cart',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
