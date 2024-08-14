class Movie {
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;

  Movie({
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }
}
