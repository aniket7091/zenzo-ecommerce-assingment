import 'package:get/get.dart';
import '../models/product_model.dart';

class FilterController extends GetxController {
  final RxString selectedCategory = 'All'.obs;
  final RxString selectedSortBy = 'Default'.obs;
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 1000.0.obs;

  static const List<String> categories = [
    'All',
    'electronics',
    'jewelery',
    "men's clothing",
    "women's clothing",
  ];

  static const List<String> sortOptions = [
    'Default',
    'Price: Low to High',
    'Price: High to Low',
    'Rating: High to Low',
  ];

  List<ProductModel> applyFilter(List<ProductModel> products) {
    List<ProductModel> result = List.from(products);

    // Category filter
    if (selectedCategory.value != 'All') {
      result = result
          .where((p) => p.category == selectedCategory.value)
          .toList();
    }

    // Price filter
    result = result
        .where((p) => p.price >= minPrice.value && p.price <= maxPrice.value)
        .toList();

    // Sort
    switch (selectedSortBy.value) {
      case 'Price: Low to High':
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating: High to Low':
        result.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
        break;
      default:
        break;
    }

    return result;
  }

  void resetFilter() {
    selectedCategory.value = 'All';
    selectedSortBy.value = 'Default';
    minPrice.value = 0.0;
    maxPrice.value = 1000.0;
  }

  bool get isFilterActive =>
      selectedCategory.value != 'All' ||
      selectedSortBy.value != 'Default' ||
      minPrice.value > 0 ||
      maxPrice.value < 1000.0;
}
