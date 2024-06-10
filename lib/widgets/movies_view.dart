import 'package:appcine/conexion/api.dart';
import 'package:appcine/widgets/carrusel.dart';
import 'package:flutter/material.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({super.key});

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api().getPeliculas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          return Carrusel(snapshot: snapshot);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
