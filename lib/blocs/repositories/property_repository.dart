import 'package:dio/dio.dart';
import 'package:envied/envied.dart';
import 'package:helloworld/config/env.dart';
import '../models/property_model.dart';

class PropertyRepository {
  final String baseUrl = '${Env().API_BASE_URL}/api/properties';
  final Dio _dio = Dio();

  Future<List<Property>> fetchProperties() async {
    final response = await _dio.get(baseUrl);
    return (response.data as List)
        .map((json) => Property.fromJson(json))
        .toList();
  }

  Future<Property> createProperty(Map<String, dynamic> propertyData) async {
    final response = await _dio.post(baseUrl, data: propertyData);
    final propertyJson = response.data['property'];
    return Property.fromJson(propertyJson);
  }
}
