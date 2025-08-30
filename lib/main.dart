import 'package:bloc_api_test/bloc/api_bloc.dart';
import 'package:bloc_api_test/repository/api_repository.dart';
import 'package:bloc_api_test/screens/api_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(create: (_) => ApiBloc(ApiRepository()), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ApiScreen(),
    );
  }
}
