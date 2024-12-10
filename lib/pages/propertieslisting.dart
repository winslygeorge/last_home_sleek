import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/property/property_bloc.dart';
import '../blocs/property/property_state.dart';
import 'propertydetails.dart';
import 'upload_property.dart';
import 'package:envied/envied.dart';

class PropertyListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implement filter functionality
            },
          ),
        ],
      ),
      body: BlocBuilder<PropertyBloc, PropertyState>(
        builder: (context, state) {
          if (state is PropertyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PropertyLoaded) {
            final properties = state.properties;
            return ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final property = properties[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PropertyDetailsPage(property: property.toJson()),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            property.main_image_path,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                property.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(property.location),
                              const SizedBox(height: 5),
                              Text(
                                '\$${property.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {
                            // Handle favorite functionality
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is PropertyError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text('No properties found.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to upload property page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UploadPropertyPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
