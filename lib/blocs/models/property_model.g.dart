// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      type: json['type'] as String,
      bedrooms: (json['bedrooms'] as num).toInt(),
      agent_name: json['agent_name'] as String,
      agent_contact: json['agent_contact'] as String,
      agent_photo_path: json['agent_photo_path'] as String,
      main_image_path: json['main_image_path'] as String,
      additional_image_paths: (json['additional_image_paths'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      price: (json['price'] as num).toDouble(),
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'type': instance.type,
      'bedrooms': instance.bedrooms,
      'agent_name': instance.agent_name,
      'agent_contact': instance.agent_contact,
      'agent_photo_path': instance.agent_photo_path,
      'main_image_path': instance.main_image_path,
      'additional_image_paths': instance.additional_image_paths,
      'price': instance.price,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at.toIso8601String(),
    };
