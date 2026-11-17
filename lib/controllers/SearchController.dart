import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductSearchController extends GetxController {
  final ProductService _productService = ProductService();

  final RxString searchQuery = ''.obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  final RxList<String> recentSearches = <String>[].obs;
  final RxBool isLoading = false.obs;

  List<ProductModel> allProducts = [];

  @override
  void onInit() {
    super.onInit();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      isLoading.value = true;
      allProducts = await _productService.fetchProducts();
    } catch (e) {
      allProducts = [];
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    searchQuery.value = query;
    if (query.trim().isEmpty) {
      filteredProducts.clear();
      return;
    }
    final q = query.toLowerCase();
    filteredProducts.assignAll(
      allProducts.where((p) =>
          p.title.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q)),
    );
  }

  void addRecentSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    recentSearches.remove(trimmed);
    recentSearches.insert(0, trimmed);
    if (recentSearches.length > 5) {
      recentSearches.removeRange(5, recentSearches.length);
    }
  }

  void clearRecentSearches() {
    recentSearches.clear();
  }

  void clearSearch() {
    searchQuery.value = '';
    filteredProducts.clear();
  }
}
