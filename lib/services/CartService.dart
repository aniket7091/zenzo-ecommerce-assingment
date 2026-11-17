
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold(
    0,
        (sum, item) => sum + (item.product.price * item.quantity),
  );

  void addToCart(ProductModel product) {
    final index = _items.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }

    notifyListeners();
  }

  void increaseQuantity(int productId) {
    final item = _items.firstWhere(
          (item) => item.product.id == productId,
    );

    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(int productId) {
    final index = _items.indexWhere(
          (item) => item.product.id == productId,
    );

    if (index == -1) return;

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }

    notifyListeners();
  }

  void removeItem(int productId) {
    _items.removeWhere(
          (item) => item.product.id == productId,
    );

    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
