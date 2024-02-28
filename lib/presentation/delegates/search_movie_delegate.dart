import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallBack searchMovies;
  final List<Movie> initialMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTime;

  SearchMovieDelegate({required this.searchMovies, required this.initialMovies});

  void clearStreams() {
    debounceMovies.close();
    _debounceTime?.cancel();
  }

  void onQueryChange( String query ){
    if ( _debounceTime?.isActive ?? false ) _debounceTime!.cancel();
    _debounceTime = Timer(const Duration(milliseconds: 500), () async {

      final movies = await searchMovies(query);
      debounceMovies.add(movies);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 100),
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear)),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () {
          clearStreams();
          return close(context, null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot) {

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MoviesView(movie: movies[index])
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    onQueryChange(query);

    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MoviesView(movie: movies[index])
        );
      },
    );
  }
}

class _MoviesView extends StatelessWidget {

  final Movie movie;

  const _MoviesView({required this.movie});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => context.push('/movie/${movie.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              height: size.height * 0.15,
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),

            const SizedBox(width: 15),

            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textTheme.titleMedium,
                  ),
                  (movie.overview.length > 100)
                  ? Text( '${movie.overview.substring(0, 105)}...' )
                  : Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow.shade800),
                      const SizedBox(width: 10),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textTheme.bodyMedium!.copyWith(color: Colors.yellow.shade900)
                      ),
                    ],
                  )
                ],
              ),
            )
      
            // Description
          ]
        ),
      ),
    );
  }
}
