import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_models.dart';

class MovieService {
  final String _apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZjY0ZjkyMzQ3MGMyODA1OWE5OTUzYjM2ZWEzYzlmZSIsIm5iZiI6MTcxOTM2OTUxNy40NTA4MzMsInN1YiI6IjY2NmNmNDdmZjUyYzE3YTNkMjk5OTE1NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GEpGSY1XrpbSfIZbyBui_cffKOiIn4m8eqUPoCv4y_4';
  final String _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc'),
      headers: {"Authorization": "Bearer $_apiKey"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
