// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Rating',
      json,
      ($checkedConvert) {
        final val = Rating(
          rate: $checkedConvert('rate', (v) => (v as num).toDouble()),
          count: $checkedConvert('count', (v) => (v as num).toInt()),
        );
        return val;
      },
    );
