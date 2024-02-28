import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/movies/movies_providers.dart';
import '../../providers/storage/favorite_movies_provider.dart';

class FavoritesViews extends ConsumerStatefulWidget {
  const FavoritesViews({super.key});

  @override
  FavoritesViewsState createState() => FavoritesViewsState();
}

class FavoritesViewsState extends ConsumerState<FavoritesViews> {

  bool isLoading = false;
  bool isLastPage = false;

  void loadNextPage() async {

    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;


    if (movies.isEmpty) {
      isLastPage = true;
    }

  }

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {

      final color = Theme.of(context).colorScheme;
      final textStyle = Theme.of(context).textTheme;

     return Scaffold(
       body: Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 60, color: color.primary),
            const Text('ohhhh rayos!!', style: TextStyle(fontSize: 37, fontWeight: FontWeight.bold)),
            Text('No tienes peliculas favoritas', style: textStyle.bodyMedium),
            const SizedBox(height: 50),
            FloatingActionButton.extended(
              icon: const Icon(Icons.home_max_outlined),
              label: const Text("Volver al inicio"),
              onPressed: () {
                ref.read(indexNavbarProvider.notifier).state = 0;
                context.go('/');
              },
            )

          ]),
       ),
     );
    }

    return Scaffold(
      body: MovieMansory(
        loadNextPage: loadNextPage,
        movies: favoriteMovies
      )
    );
  }
}