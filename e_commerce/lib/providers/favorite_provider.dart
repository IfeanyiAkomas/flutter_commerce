import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Map<String, dynamic>>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Map<String, dynamic> product) {
    final exists = state.any((item) => item['id'] == product['id']);
    if (exists) {
      state = state.where((item) => item['id'] != product['id']).toList();
    } else {
      state = [...state, product];
    }
  }

  bool isFavorite(String id) {
    return state.any((item) => item['id'] == id);
  }
}
