import 'dart:convert';
import 'package:appcine/model/peliculas.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _peliculasUrl = 'https://api.themoviedb.org/3/trending/movie/day?api_key=999d33c56bea0d4a0d5ce4fb53fbd5e3&language=es-MX';


   static const _proximaPeliculasUrl = 'https://api.themoviedb.org/3/movie/upcoming?api_key=999d33c56bea0d4a0d5ce4fb53fbd5e3&language=es-MX';

   static const _masPeliculasUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=999d33c56bea0d4a0d5ce4fb53fbd5e3&language=es-MX';

  Future<List<Pelicula>> getPeliculas() async {
    final respuesta = await http.get(Uri.parse(_peliculasUrl));
    if (respuesta.statusCode == 200) {
      final data = json.decode(respuesta.body)['results'] as List;
      return data.map((pelicula) => Pelicula.fromJson(pelicula)).toList();
    } else {
      throw Exception('Ocurrió un error');
    }
  }


    Future<List<Pelicula>> getProximaPeliculas() async {
    final respuesta = await http.get(Uri.parse(_proximaPeliculasUrl));
    if (respuesta.statusCode == 200) {
      final data = json.decode(respuesta.body)['results'] as List;
      return data.map((pelicula) => Pelicula.fromJson(pelicula)).toList();
    } else {
      throw Exception('Ocurrió un error');
    }
  }




      Future<List<Pelicula>> getMasPeliculas() async {
    final respuesta = await http.get(Uri.parse(_masPeliculasUrl));
    if (respuesta.statusCode == 200) {
      final data = json.decode(respuesta.body)['results'] as List;
      return data.map((pelicula) => Pelicula.fromJson(pelicula)).toList();
    } else {
      throw Exception('Ocurrió un error');
    }
  }
}
