class Product {
  final String id;
  final String name;
  final int price;
  final String category;
  final String description;
  final int stock;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.stock,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      stock: json['stock'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'stock': stock,
      'imageUrl': imageUrl,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.category == category &&
        other.description == description &&
        other.stock == stock &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        category.hashCode ^
        description.hashCode ^
        stock.hashCode ^
        imageUrl.hashCode;
  }
}
