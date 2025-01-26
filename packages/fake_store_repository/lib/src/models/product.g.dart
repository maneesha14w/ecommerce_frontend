// GENERATED CODE - DO NOT MODIFY BY HAND

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
          description: $checkedConvert('description', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'image': instance.image,
    };
