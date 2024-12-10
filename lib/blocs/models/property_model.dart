import 'package:json_annotation/json_annotation.dart';

part 'property_model.g.dart';

@JsonSerializable()
class Property {
  final int id;
  final String name;
  final String description;
  final String location;
  final String type;
  final int bedrooms;
  final String agent_name;
  final String agent_contact;
  final String agent_photo_path;
  final String main_image_path;
  final List<String> additional_image_paths;
  final double price;
  final DateTime created_at;
  final DateTime updated_at;

  Property({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.type,
    required this.bedrooms,
    required this.agent_name,
    required this.agent_contact,
    required this.agent_photo_path,
    required this.main_image_path,
    required this.additional_image_paths,
    required this.price,
    required this.created_at,
    required this.updated_at,
  });

  // Method to convert Property object to Map<String, dynamic

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
