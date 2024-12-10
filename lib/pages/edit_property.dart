import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'loading.dart';
import 'package:envied/envied.dart';
import '../config/env.dart';

class EditPropertyPage extends StatefulWidget {
  final Map<String, dynamic> property;

  EditPropertyPage({required this.property});

  @override
  _EditPropertyPageState createState() => _EditPropertyPageState();
}

class _EditPropertyPageState extends State<EditPropertyPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late TextEditingController _typeController;
  late TextEditingController _bedroomsController;
  late TextEditingController _priceController;
  late TextEditingController _agentNameController;
  late TextEditingController _agentContactController;
  late TextEditingController _mainImageController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.property['name']);
    _descriptionController =
        TextEditingController(text: widget.property['description']);
    _locationController =
        TextEditingController(text: widget.property['location']);
    _typeController = TextEditingController(text: widget.property['type']);
    _bedroomsController =
        TextEditingController(text: widget.property['bedrooms'].toString());
    _priceController =
        TextEditingController(text: widget.property['price'].toString());
    _agentNameController =
        TextEditingController(text: widget.property['agent_name']);
    _agentContactController =
        TextEditingController(text: widget.property['agent_contact']);
    _mainImageController =
        TextEditingController(text: widget.property['main_image_path']);
  }

  Future<void> _editProperty() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
        '${Env().API_BASE_URL}/api/properties/${widget.property['id']}');
    final payload = {
      "name": _nameController.text,
      "description": _descriptionController.text,
      "location": _locationController.text,
      "type": _typeController.text,
      "bedrooms": int.parse(_bedroomsController.text),
      "price": double.parse(_priceController.text),
      "agent_name": _agentNameController.text,
      "agent_contact": _agentContactController.text,
      "main_image_path": _mainImageController.text,
    };

    try {
      final response =
          await http.put(url, body: json.encode(payload), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Property updated successfully!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingScreen(),
          ),
        );
      } else {
        throw Exception('Failed to update property');
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
        title: Text('Edit Property'),
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
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter price' : null,
              ),

              TextFormField(
                controller: _mainImageController,
                decoration: InputDecoration(labelText: 'Main Image'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter main image' : null,
              ),
              TextFormField(
                controller: _agentNameController,
                decoration: InputDecoration(labelText: 'Agent Name '),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter agentName' : null,
              ),
              SizedBox(height: 20), // No 'const' or '...' here
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _editProperty,
                      child: Text('Update Property'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
