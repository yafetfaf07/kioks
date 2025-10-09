class Product {
  final String id;
  final String name;
  final String category;
  final int price;
  final int quantity;
  final String imageUrl;
  final int changedQuantity;
  int cartChangeQuantity;

  Product( {
    required this.changedQuantity,
    required this.quantity,
    required this.category,
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.price,
    this.cartChangeQuantity=1
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "category": category,
      "price": price,
      "quantity": quantity,
      "imageUrl": imageUrl,
      "changedQuantity":changedQuantity
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      changedQuantity:json['changedQuantity'],
      quantity: json['quantity'],
      category: json['category'],
      imageUrl: json['imageUrl'] ?? "",
      id: json['_id'],
      name: json['name'],
      price: json['price'],
    );
  }
}
