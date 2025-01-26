import 'package:fake_store_api/src/models/rating.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String category;
  final String description;
  final String image;
  final Rating rating;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
