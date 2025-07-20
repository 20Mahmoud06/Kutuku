import 'package:final_project/core/widgets/custom_appbar.dart';
import 'package:final_project/core/widgets/custom_button.dart';
import 'package:final_project/core/widgets/custom_text.dart';
import 'package:final_project/core/widgets/gallery_container.dart';
import 'package:final_project/core/widgets/sizes_container.dart';
import 'package:final_project/features/product_details/data/models/sizes_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
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
    List<String> galleryImages = [selectedProduct.image, selectedProduct.image, selectedProduct.image]; // Example gallery
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          rightIcon: Icons.shopping_bag_outlined,
          leftIcon: Icons.arrow_back_ios_new,
          titleText: 'Men’s Shoes',
          onLeftIconPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: AppColors.backgroundAppbar,
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
        Expanded(
          child: _buildProductInfo(galleryImages),
        ),
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
        Expanded(
          flex: 1,
          child: _buildProductInfo(galleryImages),
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    return Container(
      height: 300,
      color: AppColors.backgroundAppbar,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
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
                    child: Text('Image Not Found',
                        style: TextStyle(color: AppColors.grey)),
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
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Best Seller',
                fontSize: 16,
                color: AppColors.lightBlue,
              ),
              const SizedBox(height: 8),
              CustomText(
                text: selectedProduct.name,
                fontSize: 24,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: '\$${selectedProduct.price.toString()}',
                fontSize: 20,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 15),
              CustomText(
                text: selectedProduct.description,
                fontSize: 16,
                color: AppColors.grey,
              ),
              const SizedBox(height: 20),
              const CustomText(
                text: 'Gallery',
                fontSize: 20,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 60,
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
                      },
                      productModel: null,
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
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: const [
                      CustomText(
                        text: 'EU',
                        fontSize: 18,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'US',
                        fontSize: 18,
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'UK',
                        fontSize: 18,
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Price',
                        fontSize: 16,
                        color: AppColors.grey,
                      ),
                      const SizedBox(height: 5),
                      CustomText(
                        text:
                        '\$${selectedProduct.price.toString()}',
                        fontSize: 20,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(width: 120),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        print('Add to cart pressed!');
                      },
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
