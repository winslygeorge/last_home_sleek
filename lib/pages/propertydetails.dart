import 'package:flutter/material.dart';
import '../blocs/models/property_model.dart';
import 'edit_property.dart'; // Import the edit property page
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'loading.dart';
import 'package:envied/envied.dart';

class PropertyDetailsPage extends StatelessWidget {
  final Map<String, dynamic> property;

  PropertyDetailsPage({required this.property});

  Future<void> _deleteProperty(BuildContext context) async {
    final url =
        Uri.parse('${Env.API_BASE_URL}/api/properties/${property['id']}');

    try {
      final response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Property deleted successfully!')),
        );
        Navigator.pop(context); // Go back to the property listing page
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingScreen(),
          ),
        );
        throw Exception('Failed to delete property');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to the edit property page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPropertyPage(property: property),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Call delete function
              _deleteProperty(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            Image.network(
              property['main_image_path'],
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Title and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        property['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${property['price'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Property Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 18),
                      const SizedBox(width: 5),
                      Text(property['location']),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Property Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailTile(
                        icon: Icons.king_bed,
                        label: '${property['bedrooms']} Bedrooms',
                      ),
                      _buildDetailTile(
                        icon: Icons.bathtub,
                        label: '${property['bedrooms']} Bathrooms',
                      ),
                      _buildDetailTile(
                        icon: Icons.kitchen,
                        label: '${property['bedrooms']} Kitchens',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(property['description']),
                  const SizedBox(height: 20),
                  // Contact Agent
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(property['agent_photo_path']),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(property['agent_name']),
                          const Text('Property Owner'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle "Get Schedule" functionality
                        },
                        child: const Text('Get Schedule'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle "Call" functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Fixed here
                        ),
                        child: const Text('Call'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile({required IconData icon, required String label}) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
