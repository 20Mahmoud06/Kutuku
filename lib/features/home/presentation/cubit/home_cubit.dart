import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/core/services/api_service.dart';
import 'package:final_project/features/home/data/models/brand_model.dart';
import 'package:final_project/features/product_details/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService _apiService;

  HomeCubit(this._apiService) : super(HomeInitial());

  // Emits a new state with the updated brand index and resets the search query.
  void selectBrand(int index) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(brandSelectedIndex: index, searchQuery: ''));
    }
  }

  // Emits a new state with the updated search query.
  void searchProducts(String query) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(searchQuery: query));
    }
  }

  // Fetches the initial list of products from the API.
  Future<void> fetchProducts() async {
    emit(HomeLoading());
    try {
      final products = await _apiService.fetchAllProducts();
      if (products != null) {
        emit(HomeLoaded(allProducts: products));
      } else {
        emit(const HomeError("Couldn't fetch products. Please try again."));
      }
    } catch (e) {
      emit(HomeError("An error occurred: ${e.toString()}"));
    }
  }
}
