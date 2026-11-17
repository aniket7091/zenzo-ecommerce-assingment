
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/CartController.dart';
import '../widgets/cart/CartItemCard.dart';
import '../widgets/cart/CartSummary.dart';
import '../widgets/cart/EmptyCart.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback? onContinueShopping;

  CartScreen({super.key, this.onContinueShopping});

  final CartController cartController = Get.find<CartController>();

  static const Color brown = Color(0xFF6F4E37);
  static const Color background = Color(0xFFFAF8F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Obx(() {
            if (cartController.cartItems.isEmpty) {
              return const SizedBox.shrink();
            }

            return IconButton(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Clear Cart?'),
                    content: const Text(
                      'Are you sure you want to remove all products?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: Get.back,
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          cartController.clearCart();
                          Get.back();
                        },
                        child: const Text(
                          'Clear',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete_outline,
                color: brown,
              ),
            );
          }),
          const SizedBox(width: 8),
        ],
      ),

      body: Obx(() {
        final items = cartController.cartItems;

        if (items.isEmpty) {
          return EmptyCart(
            onContinueShopping: onContinueShopping ?? () => Get.back(),
          );
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
          children: [
            // Cart item count
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    color: brown,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${cartController.totalItems} items in your cart',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Shopping Bag',
                    style: TextStyle(
                      color: brown,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Your Products',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            // Product cards
            ...items.map(
                  (item) => CartItemCard(
                item: item,
                onIncrease: () => cartController.increaseQuantity(
                  item.product.id,
                ),
                onDecrease: () => cartController.decreaseQuantity(
                  item.product.id,
                ),
                onRemove: () => cartController.removeItem(
                  item.product.id,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Order summary
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Summary',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),

                  _summaryRow(
                    'Subtotal',
                    cartController.totalPrice,
                  ),

                  const SizedBox(height: 12),

                  _summaryRow(
                    'Delivery Fee',
                    0,
                    value: 'Free',
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: Color(0xFFEEEEEE)),
                  ),

                  _summaryRow(
                    'Total Amount',
                    cartController.totalPrice,
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Row(
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: brown,
                  size: 17,
                ),
                SizedBox(width: 8),
                Text(
                  'Safe and secure checkout',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        );
      }),

      bottomNavigationBar: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${cartController.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: brown,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.snackbar(
                          'Checkout',
                          'Checkout feature coming soon!',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brown,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Checkout',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _summaryRow(
      String title,
      double amount, {
        String? value,
        bool isTotal = false,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[600],
          ),
        ),
        Text(
          value ?? '₹${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 17 : 13,
            fontWeight: FontWeight.bold,
            color: isTotal ? brown : Colors.black,
          ),
        ),
      ],
    );
  }
}
