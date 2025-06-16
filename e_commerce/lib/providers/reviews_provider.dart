import 'package:e_commerce/models/review_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewsProvider = StateNotifierProvider.family<ReviewsNotifier, List<Review>, String>(
  (ref, productId) => ReviewsNotifier(),
);

class ReviewsNotifier extends StateNotifier<List<Review>> {
  ReviewsNotifier() : super([]);

  void addReview(Review review) {
    state = [...state, review];
  }
}
