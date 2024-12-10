abstract class PropertyEvent {}

class LoadProperties extends PropertyEvent {}

class CreateProperty extends PropertyEvent {
  final Map<String, dynamic> propertyData;

  CreateProperty(this.propertyData);
}
