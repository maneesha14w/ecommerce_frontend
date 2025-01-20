class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  final int id;
  final String title;
  final double price;
  final double category;
  final double description;
  final double image;
}
