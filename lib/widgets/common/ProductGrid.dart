
import 'package:flutter/material.dart';
import 'package:zenzo/widgets/common/ProductCard.dart';
import 'package:zenzo/models/product_model.dart';

import '../../screens/product_details.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  final int? limit;

  const ProductGrid({
    super.key,
    required this.products,
    this.limit,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),

      itemCount: limit != null && limit! < products.length
          ? limit!
          : products.length,

      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(
          product: product,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsScreen(product: product),
              ),
            );
          },
        );
      },
    );
  }
}
