import 'package:dio/dio.dart';
import '../models/property_model.dart';
import '../../env/env.dart';

class PropertyRepository {
  final String bUrl = Env.API_BASE_URL;
  final String baseUrl = '/api/properties';
  final Dio _dio = Dio();

  Future<List<Property>> fetchProperties() async {
    final String bUrl = Env.getBaseUrl();
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
