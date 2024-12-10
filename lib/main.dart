import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/property/property_bloc.dart';
import 'blocs/repositories/property_repository.dart';
import 'blocs/property/property_bloc.dart';
import 'blocs/property/property_event.dart';
import 'pages/loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              PropertyBloc(PropertyRepository())..add(LoadProperties()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sleek Properties',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoadingScreen(),
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Real Estate App',
//     theme: ThemeData(
//       primaryColor: AppColor.primary,
//     ),
//     home: const RootApp(),
//   );
// }
