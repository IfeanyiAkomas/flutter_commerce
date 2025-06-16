import 'package:e_commerce/models/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(CartItem item) {
    final index = state.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      final updated = state[index].copyWith(quantity: state[index].quantity + 1);
      state = [...state]..[index] = updated;
    } else {
      state = [...state, item];
    }
  }

  void removeFromCart(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void clearCart() {
    state = [];
  }
}
