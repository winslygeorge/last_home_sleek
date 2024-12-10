import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'loading.dart';

class UploadPropertyPage extends StatefulWidget {
  @override
  _UploadPropertyPageState createState() => _UploadPropertyPageState();
}

class _UploadPropertyPageState extends State<UploadPropertyPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _agentNameController = TextEditingController();
  final TextEditingController _agentContactController = TextEditingController();
  final TextEditingController _mainImageController = TextEditingController();

  bool _isLoading = false;

  Future<void> _uploadProperty() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('${Env.API_BASE_URL}/api/properties');
    final payload = {
      "name": _nameController.text,
      "description": _descriptionController.text,
      "location": _locationController.text,
      "type": _typeController.text,
      "bedrooms": int.parse(_bedroomsController.text),
      "price": double.parse(_priceController.text),
      "agent_name": _agentNameController.text,
      "agent_contact": _agentContactController.text,
      "agent_photo_path":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Outdoors-man-portrait_%28cropped%29.jpg",
      "main_image_path": _mainImageController.text,
      "additional_image_paths": []
    };

    try {
      final response =
          await http.post(url, body: json.encode(payload), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Property uploaded successfully!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingScreen(),
          ),
        );
      } else {
        throw Exception('Failed to upload property');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Property'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Property Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter property name' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter property description' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter property location' : null,
              ),
              TextFormField(
                controller: _typeController,
                decoration:
                    InputDecoration(labelText: 'Type (e.g., Buy, Rent)'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter property type' : null,
              ),
              TextFormField(
                controller: _bedroomsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Number of Bedrooms'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter number of bedrooms' : null,
              ),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter price' : null,
              ),
              TextFormField(
                controller: _agentNameController,
                decoration: InputDecoration(labelText: 'Agent Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter agent name' : null,
              ),
              TextFormField(
                controller: _agentContactController,
                decoration: InputDecoration(labelText: 'Agent Contact'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter agent contact' : null,
              ),
              TextFormField(
                controller: _mainImageController,
                decoration: InputDecoration(labelText: 'Main Image URL'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter main image URL' : null,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _uploadProperty,
                      child: Text('Upload Property'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
