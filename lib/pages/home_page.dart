// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../models/movie_models.dart';
import '../services/movie_service.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = MovieService().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load movies'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                final imageUrl =
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}';
                final backDrop =
                    'https://image.tmdb.org/t/p/w500${movie.backDropPath}';
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                imageUrl,
                                scale: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                        appBar: AppBar(
                                          title: const Text(' Poster QR Code'),
                                        ),
                                        body: Center(
                                          child: PrettyQr(
                                            data: imageUrl.toString(),
                                            size: 200,
                                            elementColor: Colors.black,
                                            roundEdges: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Generate QR"),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.network(
                                backDrop,
                                scale: 2,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                        appBar: AppBar(
                                          title: const Text('Backdrop QR Code'),
                                        ),
                                        body: Center(
                                          child: PrettyQr(
                                            data: imageUrl.toString(),
                                            size: 200,
                                            elementColor: Colors.black,
                                            roundEdges: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Generate QR"),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(movie.title),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(movie.overview),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No movies found'));
          }
        },
      ),
    );
  }
}
