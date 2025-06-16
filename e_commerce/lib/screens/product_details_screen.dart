import 'dart:convert';
import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/models/review_model.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/favorite_provider.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? product;

  const ProductDetailsScreen({super.key, this.product});

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  bool isExpanded = false;
  bool isLoading = false;
  String? error;

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  late Map<String, dynamic> product;

  final List<Review> reviews = [
    Review(
      name: "Jane Doe",
      image: "https://i.pravatar.cc/150?img=4",
      comment: "Great quality product!",
    ),
    Review(
      name: "John Smith",
      image: "https://i.pravatar.cc/150?img=6",
      comment: "Loved it, would recommend.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Assign product from widget
    if (widget.product != null) {
      product = widget.product!;
    } else {
      error = "Product not found";
    }
  }

  Future<void> addToCart(
    WidgetRef ref,
    Map<String, dynamic>? product,
    BuildContext context,
  ) async {
    if (product == null) return;

    try {
      final cartItem = CartItem(
        id: product['id'].toString(),
        title: product['title'] ?? 'No Title',
        image: product['image'] ?? '',
        price: double.tryParse(product['price'].toString()) ?? 0.0,
      );

      ref.read(cartProvider.notifier).addToCart(cartItem);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Added to cart')));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error adding to cart: $e')));
    }
  }

  void submitReviewFromBottomBar() {
    if (_commentController.text.trim().isEmpty) return;
    setState(() {
      reviews.add(
        Review(
          name: "You",
          image: "https://i.pravatar.cc/150?u=me",
          comment: _commentController.text.trim(),
        ),
      );
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product!['title'] ?? 'Product Details'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Favorite Button
          Consumer(
            builder: (context, ref, _) {
              final favorites = ref.watch(favoritesProvider);
              final isFav = favorites.any(
                (item) => item['id'] == product!['id'],
              );

              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  ref.read(favoritesProvider.notifier).toggleFavorite(product!);
                },
              );
            },
          ),

          // Cart Button with Badge
          Consumer(
            builder: (context, ref, _) {
              final cart = ref.watch(cartProvider);
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                  ),
                  if (cart.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cart.length.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: product!['image'],
                child: Image.network(
                  product['image'],
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product!['title'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "\$${product!['price']}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: AnimatedCrossFade(
                firstChild: Text(
                  product!['description'],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                secondChild: Text(
                  product!['description'],
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ),
            TextButton(
              onPressed: () => setState(() => isExpanded = !isExpanded),
              child: Text(
                isExpanded ? "Show Less" : "Read More",
                style: const TextStyle(color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Reviews",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...reviews.map(
              (review) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(review.image),
                ),
                title: Text(review.name),
                subtitle: Text(review.comment),
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.comment, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: const InputDecoration(
                            hintText: "Write a review...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blueAccent),
                        onPressed: submitReviewFromBottomBar,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => addToCart(ref, product, context),
                icon: const Icon(Icons.shopping_cart),
                label: const Text("Add"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
