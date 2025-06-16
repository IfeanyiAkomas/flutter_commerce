import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../services/api_service.dart';

final productProvider = FutureProvider<List<Product>>((ref) async {
  return await ApiService.fetchProducts();
});
