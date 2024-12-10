import 'package:helloworld/blocs/models/property_model.dart';

import '../models/property_model.dart';

abstract class PropertyState {}

class PropertyLoading extends PropertyState {}

class PropertyLoaded extends PropertyState {
  final List<Property> properties;

  PropertyLoaded(this.properties);
}

class PropertyError extends PropertyState {
  final String message;

  PropertyError(this.message);
}

class PropertyCreated extends PropertyState {
  final Property property;

  PropertyCreated(this.property);
}
