part of 'home_cubit.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductModel> allProducts; // Stores the original list of all products
  final int brandSelectedIndex;
  final String searchQuery; // Holds the current search query

  const HomeLoaded({
    required this.allProducts,
    this.brandSelectedIndex = 0,
    this.searchQuery = '', // Defaults to an empty search
  });

  // A computed property to get the list of products filtered by brand and search query.
  List<ProductModel> get filteredProducts {
    final brandName = BrandModels[brandSelectedIndex].name;
    // Start with products of the selected brand.
    final brandFiltered = allProducts
        .where((p) => p.brand.toLowerCase() == brandName.toLowerCase())
        .toList();

    // If there's a search query, filter the brand list further by product name.
    if (searchQuery.isNotEmpty) {
      return brandFiltered
          .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Otherwise, return the list filtered only by brand.
    return brandFiltered;
  }

  // A computed property for the "New Arrivals" list.
  // This list is also filtered by the search query if one exists.
  List<ProductModel> get newArrivals {
    if (searchQuery.isNotEmpty) {
      return allProducts
          .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    // Default logic for "New Arrivals": show one unique product per brand.
    final Map<String, ProductModel> brandProductMap = {};
    for (var product in allProducts) {
      brandProductMap.putIfAbsent(product.brand.toLowerCase(), () => product);
    }
    return brandProductMap.values.toList()..shuffle();
  }

  // copyWith method to easily create a new state instance with updated values.
  HomeLoaded copyWith({
    List<ProductModel>? allProducts,
    int? brandSelectedIndex,
    String? searchQuery,
  }) {
    return HomeLoaded(
      allProducts: allProducts ?? this.allProducts,
      brandSelectedIndex: brandSelectedIndex ?? this.brandSelectedIndex,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props => [allProducts, brandSelectedIndex, searchQuery];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
