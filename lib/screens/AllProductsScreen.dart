import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenzo/controllers/FilterController.dart';
import 'package:zenzo/core/constants/AppColor.dart';
import 'package:zenzo/models/product_model.dart';
import 'package:zenzo/screens/SearchScreen.dart';
import 'package:zenzo/services/product_service.dart';
import 'package:zenzo/widgets/common/ProductGrid.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final ProductService _productService = ProductService();
  late Future<List<ProductModel>> _productsFuture;
  late FilterController _filterController;

  @override
  void initState() {
    super.initState();
    _filterController = Get.find<FilterController>();
    _productsFuture = _productService.fetchProducts();
  }

  void _showFilterSheet(BuildContext context) {
    // Local temp values for the sheet
    String tempCategory = _filterController.selectedCategory.value;
    String tempSortBy = _filterController.selectedSortBy.value;
    double tempMin = _filterController.minPrice.value;
    double tempMax = _filterController.maxPrice.value;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filter Products',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setSheetState(() {
                              tempCategory = 'All';
                              tempSortBy = 'Default';
                              tempMin = 0;
                              tempMax = 1000;
                            });
                          },
                          child: Text(
                            'Reset',
                            style: TextStyle(color: AppColors.brownDark),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Category',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: FilterController.categories.map((cat) {
                        final selected = tempCategory == cat;
                        return GestureDetector(
                          onTap: () =>
                              setSheetState(() => tempCategory = cat),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.brownDark
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.brownDark,
                              ),
                            ),
                            child: Text(
                              cat,
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : AppColors.brownDark,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Sort By',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: FilterController.sortOptions.map((opt) {
                        final selected = tempSortBy == opt;
                        return GestureDetector(
                          onTap: () =>
                              setSheetState(() => tempSortBy = opt),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.brownDark
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.brownDark,
                              ),
                            ),
                            child: Text(
                              opt,
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : AppColors.brownDark,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Price Range: \$${tempMin.toStringAsFixed(0)} - \$${tempMax.toStringAsFixed(0)}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    RangeSlider(
                      values: RangeValues(tempMin, tempMax),
                      min: 0,
                      max: 1000,
                      divisions: 100,
                      activeColor: AppColors.brownDark,
                      onChanged: (values) {
                        setSheetState(() {
                          tempMin = values.start;
                          tempMax = values.end;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brownDark,
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          _filterController.selectedCategory.value =
                              tempCategory;
                          _filterController.selectedSortBy.value =
                              tempSortBy;
                          _filterController.minPrice.value = tempMin;
                          _filterController.maxPrice.value = tempMax;
                          Navigator.pop(ctx);
                          setState(() {});
                        },
                        child: Text(
                          'Apply Filter',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'All Products',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Search icon
          IconButton(
            icon: const Icon(CupertinoIcons.search, color: Colors.black87),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
          // Filter icon
          Obx(() => IconButton(
                icon: Icon(
                  Icons.tune,
                  color: _filterController.isFilterActive
                      ? AppColors.brownDark
                      : Colors.black87,
                ),
                onPressed: () => _showFilterSheet(context),
              )),
        ],
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return Obx(() {
            final filtered =
                _filterController.applyFilter(snapshot.data!);
            if (filtered.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off,
                        size: 60, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      'No products match the filters',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textGray,
                      ),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ProductGrid(products: filtered),
            );
          });
        },
      ),
    );
  }
}
