import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/property/property_bloc.dart';
import '../blocs/property/property_event.dart';
import '../blocs/property/property_state.dart';
import 'propertieslisting.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger property loading after widget is built
    context.read<PropertyBloc>().add(LoadProperties());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyBloc, PropertyState>(
      listener: (context, state) {
        if (state is PropertyLoaded) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PropertyListingPage()),
          );
        } else if (state is PropertyError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: state is PropertyLoading
                ? SpinKitWave(color: Colors.blue, size: 50.0)
                : const Text('Initializing...'),
          ),
        );
      },
    );
  }
}
