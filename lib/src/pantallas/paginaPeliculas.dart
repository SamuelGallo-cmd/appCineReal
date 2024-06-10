
import 'package:appcine/conexion/api.dart';

import 'package:appcine/model/peliculas.dart';
import 'package:appcine/widgets/carrusel.dart';
import 'package:flutter/material.dart';

class PaginaPeliculas extends StatefulWidget {
  const PaginaPeliculas({super.key});

  @override
  State<PaginaPeliculas> createState() => _PaginaPeliculasState();
}

class _PaginaPeliculasState extends State<PaginaPeliculas> {
  late Future<List<Pelicula>> cartelera;
  late Future<List<Pelicula>> proximaPeliculas;
  late Future<List<Pelicula>> masPeliculas;

  @override
  void initState() {
    super.initState();
    cartelera = Api().getPeliculas();
    proximaPeliculas = Api().getProximaPeliculas();
    masPeliculas = Api().getMasPeliculas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multicines'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Cartelera',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            FutureBuilder<List<Pelicula>>(
              future: cartelera,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  return Carrusel(snapshot: snapshot);
                } else {
                  return const Center(child: Text('No hay datos disponibles'));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Próximamente',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            FutureBuilder<List<Pelicula>>(
              future: proximaPeliculas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  return Carrusel(snapshot: snapshot);
                } else {
                  return const Center(child: Text('No hay datos disponibles'));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Más películas',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            FutureBuilder<List<Pelicula>>(
              future: masPeliculas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  return Carrusel(snapshot: snapshot);
                } else {
                  return const Center(child: Text('No hay datos disponibles'));
                }
              },
            ),

              const Padding(
              padding: EdgeInsets.all(20.0),
            ),
          ],
        ),
      ),
    );
  }
}
