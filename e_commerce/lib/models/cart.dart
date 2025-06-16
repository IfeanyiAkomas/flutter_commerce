class CartItem {
  final String id;
  final String title;
  final double price;
  final String image;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      title: title,
      price: price,
      image: image,
      quantity: quantity ?? this.quantity,
    );
  }
}
