import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/property_model.dart';
import '../repositories/property_repository.dart';
import 'property_event.dart';
import 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository repository;

  PropertyBloc(this.repository) : super(PropertyLoading()) {
    on<LoadProperties>((event, emit) async {
      try {
        emit(PropertyLoading());
        final properties = await repository.fetchProperties();
        emit(PropertyLoaded(properties));
      } catch (e) {
        emit(PropertyError("Failed to fetch properties"));
      }
    });
  }
}
