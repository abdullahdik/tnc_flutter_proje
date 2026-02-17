class Plant {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;
  final String light;
  final String water;

  Plant({
    required this.id, required this.name, required this.description,
    required this.price, required this.image, required this.category,
    required this.light, required this.water,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
      category: json['category'],
      light: json['light'],
      water: json['water'],
    );
  }
}