
import 'package:dog_breed_app/bloc/dog_bloc.dart';
import 'package:dog_breed_app/repository/dog_repository.dart';
import 'package:dog_breed_app/ui/views/view_home.dart';
import 'package:dog_breed_app/ui/views/view_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const BreedApp());
}

class BreedApp extends StatelessWidget {
  const BreedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DogBloc(dogRepository: DogRepository()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dog Breed App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ViewSplash(),
          routes: {
            '/home': (context) => ViewHome(),
          }),
    );
  }
}
