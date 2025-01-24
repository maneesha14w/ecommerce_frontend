import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

//import 'package:fake_store_repository/fake_store_repository.dart' hide Product;
import 'package:fake_store_repository/fake_store_repository.dart'
    as store_repository;

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  factory Product.fromRepository(store_repository.Product product) {
    return Product(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      image: product.image,
    );
  }

  final int id;
  final String title;
  final double price;
  final String description;
  final String image;

  @override
  List<Object> get props => [id, title, price, description, image];

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
}
