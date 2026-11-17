
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzo/controllers/CartController.dart';
import 'package:zenzo/models/product_model.dart';

import '../widgets/product_details/ProductDetailsHeader.dart';
import '../widgets/product_details/ProductImage.dart';
import '../widgets/product_details/ProductInfo.dart';
import '../widgets/product_details/QuantitySelector.dart';
import '../widgets/product_details/BottomCartBar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<ProductDetailsScreen> {

  bool isFavorite = false;
  int quantity = 1;

  final CartController cartController = Get.find<CartController>();

  static const Color backgroundColor = Color(0xFFFAF8F5);
  static const Color primaryBrown = Color(0xFF6F4E37);

  // Add To Cart
  void _addToCart() {
    cartController.addToCart(widget.product, quantity: quantity);
  }

  // Increase Quantity
  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  // Decrease Quantity
  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  // Toggle Favorite
  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: backgroundColor,

      // Bottom Cart Component
      bottomNavigationBar: BottomCartBar(
        product: product,
        quantity: quantity,
        onAddToCart: _addToCart,
      ),

      // Main Body
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Header Component
            SliverToBoxAdapter(
              child: ProductDetailsHeader(
                isFavorite: isFavorite,
                onBack: () => Navigator.pop(context),
                onFavorite: _toggleFavorite,
              ),
            ),

            // Product Image Component
            SliverToBoxAdapter(
              child: ProductImage(
                product: product,
              ),
            ),

            // Product Info Component
            SliverToBoxAdapter(
              child: ProductInfo(
                product: product,
              ),
            ),

            // Quantity Component
            SliverToBoxAdapter(
              child: QuantitySelector(
                quantity: quantity,
                onIncrease: _increaseQuantity,
                onDecrease: _decreaseQuantity,
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
          ],
        ),
      ),
    );
  }
}
