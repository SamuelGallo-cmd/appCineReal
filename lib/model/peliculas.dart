class Pelicula {
  final String backdrop_path;
  final String id;
  final String original_title;
  final String overview;
  final String poster_path;

  final String adult;
  final String title;
  final String original_language;
  final String popularity;
  final String release_date;
  final String video;
  final String vote_average;
  final String vote_count;

  Pelicula({
    required this.backdrop_path,
    required this.id,
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.adult,
    required this.title,
    required this.original_language,
    required this.popularity,
    required this.release_date,
    required this.video,
    required this.vote_average,
    required this.vote_count,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) {
    return Pelicula(
      backdrop_path: json["backdrop_path"] ?? '',
      id: json["id"].toString(),  
      original_title: json["original_title"] ?? '',
      overview: json["overview"] ?? '',
      poster_path: json["poster_path"] ?? '',
      adult: json["adult"].toString(),  
      title: json["title"] ?? '',
      original_language: json["original_language"] ?? '',
      popularity: json["popularity"].toString(),  
      release_date: json["release_date"] ?? '',
      video: json["video"].toString(), 
      vote_average: json["vote_average"].toString(),  
      vote_count: json["vote_count"].toString(),  
    );
  }
}
