// ignore: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:appcine/model/peliculas.dart';

class InfoPelicula extends StatefulWidget {
  final Pelicula pelicula;

  const InfoPelicula({super.key, required this.pelicula});

  @override
  // ignore: library_private_types_in_public_api
  _InfoPeliculaState createState() => _InfoPeliculaState();
}

class _InfoPeliculaState extends State<InfoPelicula> {
  late Future<String?> _trailerFuture;
  bool _showTrailer = false;

  @override
  void initState() {
    super.initState();
    _trailerFuture = fetchTrailer(int.parse(widget.pelicula.id));
  }

  Future<String?> fetchTrailer(int movieId) async {
    const apiKey = '999d33c56bea0d4a0d5ce4fb53fbd5e3';
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=es-MX';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      if (data.isNotEmpty) {
        return data[0]['key']; 
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Container(
              height: 75,
              width: 75,
              margin: const EdgeInsets.only(
                top: 8,
                left: 8,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 209, 213, 221),
                borderRadius: BorderRadius.circular(7),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            backgroundColor: Colors.blue,
            expandedHeight: 500,
            pinned: true,
            floating: true,

            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://image.tmdb.org/t/p/w500/${widget.pelicula.poster_path}',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pelicula.title,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 42, 41, 41),
                      fontSize: 30,
                       fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Resumen',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.pelicula.overview,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 42, 41, 41),
                      fontSize: 16,
                       fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text("Lanzamiento: ${widget.pelicula.release_date}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 42, 41, 41),
                      fontSize: 16,
                       fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<String?>(
              future: _trailerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error al cargar el tráiler');
                } else if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _showTrailer = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tráiler',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: _showTrailer
                                ? WebView(
                                    initialUrl:
                                        'https://www.youtube.com/watch?v=${snapshot.data}',
                                    javascriptMode: JavascriptMode.unrestricted,
                                  )
                                : Image.network(
                                    'https://img.youtube.com/vi/${snapshot.data}/0.jpg',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Tráiler no disponible',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
