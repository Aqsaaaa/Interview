class Movie {
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final String backDropPath;

  Movie({
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.backDropPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      backDropPath: json['backdrop_path'],
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }
}
