
import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductImage extends StatelessWidget {
  final ProductModel product;

  const ProductImage({
    super.key,
    required this.product,
  });

  static const Color primaryBrown = Color(0xFF6F4E37);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.network(
        product.image,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 70,
              color: Colors.grey,
            ),
          );
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;

          return const Center(
            child: CircularProgressIndicator(
              color: primaryBrown,
            ),
          );
        },
      ),
    );
  }
}
