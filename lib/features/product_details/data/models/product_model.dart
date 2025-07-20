import 'dart:convert';

ProductModel ProductModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

class ProductModel {
  final String id;
  final String name;
  final String brand;
  final String image;
  final double price;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.image,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'],
      brand: json['brand'],
      image: json['image'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'],
    );
  }

  factory ProductModel.empty() {
    return ProductModel(
      id: '',
      name: '',
      brand: '',
      image: '',
      price: 0.0,
      description: '',
    );
  }
}