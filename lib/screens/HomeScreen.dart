
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenzo/controllers/FilterController.dart';
import 'package:zenzo/core/constants/AppColor.dart';
import 'package:zenzo/screens/AllProductsScreen.dart';
import 'package:zenzo/widgets/common/App_Headder.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';
import '../widgets/common/ProductGrid.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController searchText = TextEditingController();
  final ProductService productService = ProductService();
  late Future<List<ProductModel>> productsFuture;
  late FilterController filterController;

  @override
  void initState() {
    super.initState();
    filterController = Get.put(FilterController(), permanent: true);
    productsFuture = productService.fetchProducts();
  }

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

  void _goToAllProducts() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllProductsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Header
              HomeHeader(searchController: searchText),

              const Gap(20),

              // Product Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Items",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const Gap(20),

                    // API Products (filtered, limited to 4)
                    FutureBuilder<List<ProductModel>>(
                      future: productsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                "Error: ${snapshot.error}",
                              ),
                            ),
                          );
                        }

                        if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text("No products found"),
                            ),
                          );
                        }

                        return Obx(() {
                          final filtered = filterController
                              .applyFilter(snapshot.data!);

                          if (filtered.isEmpty) {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(
                                  "No products match the filters",
                                  style: TextStyle(
                                    color: AppColors.textGray,
                                  ),
                                ),
                              ),
                            );
                          }

                          return Column(
                            children: [
                              // "View All" header link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: _goToAllProducts,
                                    child: Text(
                                      "View All",
                                      style: GoogleFonts.poppins(
                                        color: AppColors.brownDark,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(12),
                              ProductGrid(
                                products: filtered,
                                limit: 4,
                              ),
                              const Gap(20),
                              // View All Button
                              Center(
                                child: OutlinedButton(
                                  onPressed: _goToAllProducts,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: AppColors.brownDark,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: Text(
                                    "View All Products",
                                    style: GoogleFonts.poppins(
                                      color: AppColors.brownDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),

              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
