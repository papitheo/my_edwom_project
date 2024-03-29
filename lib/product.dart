class Product {
  final String? id;
  final String name;
  final String description;
  final double price;
  final String farm;
  final String imageUrl;
  Product({
    this.id,
    required this.name,
    required this.farm,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  Product.fromMap(Map<String, dynamic> map)
      : name = map['name'] ?? "",
        id = map['id'] ?? "",
        farm= map['farm']??"",
        description = map['description'] ?? "",
        price = map['price'] ?? 0.0,
        imageUrl = map['imageUrl'] ?? "";

  Map<String, dynamic> toMap(String id) {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'farm':farm,
      'imageUrl': imageUrl,
    };
  }
}
