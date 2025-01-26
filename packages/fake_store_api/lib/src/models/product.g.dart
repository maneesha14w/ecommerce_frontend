// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Product',
      json,
      ($checkedConvert) {
        final val = Product(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          title: $checkedConvert('title', (v) => v as String),
          price: $checkedConvert('price', (v) => (v as num).toDouble()),
          category: $checkedConvert('category', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String),
          rating: $checkedConvert(
              'rating', (v) => Rating.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );
