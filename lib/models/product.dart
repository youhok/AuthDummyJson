class Product {
  final int id;
  final String title;
  final String description;
  final String image;
  final double price; // Added price field

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['thumbnail'],
      price: json['price'].toDouble(), // Parse price as double
    );
  }
}
