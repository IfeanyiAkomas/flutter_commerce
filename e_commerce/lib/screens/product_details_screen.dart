import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(product.image),
            SizedBox(height: 10),
            Text(product.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("\$${product.price}", style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 10),
            Text(product.description),
            SizedBox(height: 10),
            Text("Category: ${product.category}"),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange),
                Text('${product.rating} (${product.ratingCount} reviews)'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
