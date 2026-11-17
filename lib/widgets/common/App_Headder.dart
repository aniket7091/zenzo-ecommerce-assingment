
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenzo/controllers/FilterController.dart';
import 'package:zenzo/core/constants/AppColor.dart';
import 'package:zenzo/screens/SearchScreen.dart';
import 'package:zenzo/widgets/common/Custom_TextField.dart';

class HomeHeader extends StatelessWidget {
  final TextEditingController searchController;

  const HomeHeader({
    super.key,
    required this.searchController,
  });

  void _showFilterSheet(BuildContext context, FilterController filterController) {
    String tempCategory = filterController.selectedCategory.value;
    String tempSortBy = filterController.selectedSortBy.value;
    double tempMin = filterController.minPrice.value;
    double tempMax = filterController.maxPrice.value;

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
                    // Title + Reset
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

                    // Category Filter
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
                              border: Border.all(color: AppColors.brownDark),
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

                    // Sort By
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
                              border: Border.all(color: AppColors.brownDark),
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

                    // Price Range Slider
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

                    // Apply Button
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
                          filterController.selectedCategory.value =
                              tempCategory;
                          filterController.selectedSortBy.value = tempSortBy;
                          filterController.minPrice.value = tempMin;
                          filterController.maxPrice.value = tempMax;
                          Navigator.pop(ctx);
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
    final FilterController filterController = Get.find<FilterController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Location Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.brownDark,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Bangalore, India",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
              CircleAvatar(
                backgroundColor: AppColors.circularAvatarGray,
                radius: 18,
                child: Icon(
                  CupertinoIcons.bell_fill,
                  color: AppColors.brownDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Search Bar + Filter Button
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                  child: AbsorbPointer(
                    child: SizedBox(
                      height: 45,
                      child: CustomTextField(
                        prefixIcon: const Icon(CupertinoIcons.search),
                        hintText: "Search Product ...",
                        controller: searchController,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Obx(() {
                final isActive = filterController.isFilterActive;
                return GestureDetector(
                  onTap: () => _showFilterSheet(context, filterController),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.brownDark.withValues(alpha: 0.85)
                          : AppColors.brownDark,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
