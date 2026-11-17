import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzo/controllers/SearchController.dart';
import 'package:zenzo/core/constants/AppColor.dart';
import 'package:zenzo/models/product_model.dart';
import 'package:zenzo/screens/product_details.dart';
import 'package:zenzo/widgets/common/ProductCard.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _textController;
  late FocusNode _focusNode;
  late ProductSearchController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = Get.put(ProductSearchController());
    _textController = TextEditingController();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    if (query.trim().isNotEmpty) {
      _searchController.addRecentSearch(query.trim());
    }
  }

  void _searchFromRecent(String query) {
    _textController.text = query;
    _textController.selection =
        TextSelection.collapsed(offset: query.length);
    _searchController.search(query);
    _searchController.addRecentSearch(query);
  }

  void _navigateToProduct(ProductModel product) {
    if (_textController.text.trim().isNotEmpty) {
      _searchController.addRecentSearch(_textController.text.trim());
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }

  static const List<String> _popularCategories = [
    'electronics',
    'jewelery',
    "men's clothing",
    "women's clothing",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leadingWidth: 40,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
        ),
        title: Container(
          height: 42,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _textController,
            focusNode: _focusNode,
            onChanged: (value) => _searchController.search(value),
            onSubmitted: _onSearchSubmitted,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: TextStyle(
                color: AppColors.textGray,
                fontSize: 14,
              ),
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: AppColors.textGray,
                size: 20,
              ),
              suffixIcon: Obx(() =>
                  _searchController.searchQuery.value.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _textController.clear();
                            _searchController.clearSearch();
                            _focusNode.requestFocus();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black54,
                            size: 20,
                          ),
                        )
                      : const SizedBox.shrink()),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 11),
            ),
          ),
        ),
        titleSpacing: 8,
      ),
      body: Obx(() {
        final query = _searchController.searchQuery.value;
        final isLoading = _searchController.isLoading.value;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show results when query is non-empty
        if (query.isNotEmpty) {
          final results = _searchController.filteredProducts;
          if (results.isEmpty) {
            return _buildNoResults(query);
          }
          return _buildResults(results);
        }

        // Show empty state (recent searches + categories)
        return _buildEmptyState();
      }),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Recent Searches
        Obx(() {
          final recents = _searchController.recentSearches;
          if (recents.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Searches',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: _searchController.clearRecentSearches,
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: AppColors.brownDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...recents.map(
                (term) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 0,
                  ),
                  leading: Icon(
                    CupertinoIcons.clock,
                    color: AppColors.textGray,
                    size: 20,
                  ),
                  title: Text(
                    term,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Icon(
                    Icons.north_west,
                    size: 16,
                    color: AppColors.textGray,
                  ),
                  onTap: () => _searchFromRecent(term),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        }),

        // Popular Categories
        const Text(
          'Popular Categories',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _popularCategories.map((cat) {
            return GestureDetector(
              onTap: () {
                _textController.text = cat;
                _searchController.search(cat);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.brownDark.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    color: AppColors.brownDark,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildResults(List<ProductModel> results) {
    return GridView.builder(
      padding: const EdgeInsets.all(14),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ProductCard(
          product: product,
          onTap: () => _navigateToProduct(product),
        );
      },
    );
  }

  Widget _buildNoResults(String query) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.search,
            size: 60,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No results for "$query"',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search term',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textGray,
            ),
          ),
        ],
      ),
    );
  }
}
