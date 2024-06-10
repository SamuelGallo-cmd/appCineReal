import 'package:appcine/src/pantallas/infoPelicula.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carrusel extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const Carrusel({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Cards(snapshot: snapshot);
  }
}

class Cards extends StatelessWidget {
  const Cards({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
          height: 300,
          autoPlay: true,
          viewportFraction: 0.60,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 2),
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoPelicula(pelicula: snapshot.data[itemIndex]),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 100,
                width: 200,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/${snapshot.data[itemIndex].poster_path}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
