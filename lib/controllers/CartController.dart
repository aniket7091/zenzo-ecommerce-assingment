
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class CartItem {
  final ProductModel product;
  final RxInt quantity;

  CartItem({
    required this.product,
    int quantity = 1,
  }) : quantity = quantity.obs;
}

class CartController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  int get totalItems =>
      cartItems.fold(0, (sum, item) => sum + item.quantity.value);

  double get totalPrice => cartItems.fold(
    0.0,
        (sum, item) =>
    sum + (item.product.price * item.quantity.value),
  );

  void addToCart(ProductModel product, {int quantity = 1}) {
    final index = cartItems.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index != -1) {
      cartItems[index].quantity.value += quantity;
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }

    Get.snackbar(
      'Added to Cart ✓',
      '${product.title.length > 30 ? product.title.substring(0, 30) + '...' : product.title} added to cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6F4E37),
      colorText: const Color(0xFFFFFFFF),
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void increaseQuantity(int productId) {
    final item = cartItems.firstWhere(
          (item) => item.product.id == productId,
    );

    item.quantity.value++;
  }

  void decreaseQuantity(int productId) {
    final index = cartItems.indexWhere(
          (item) => item.product.id == productId,
    );

    if (index == -1) return;

    if (cartItems[index].quantity.value > 1) {
      cartItems[index].quantity.value--;
    } else {
      cartItems.removeAt(index);
    }
  }

  void removeItem(int productId) {
    cartItems.removeWhere(
          (item) => item.product.id == productId,
    );
  }

  void clearCart() {
    cartItems.clear();
  }
}
