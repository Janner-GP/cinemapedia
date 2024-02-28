import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRespository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRespository: localStorageRespository);
});


class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {

  int page = 0;
  final LocalStorageRepository localStorageRespository;

  StorageMoviesNotifier({required this.localStorageRespository}): super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRespository.getFavoriteMovies(offset: page * 10);
    page++;

    final tempMoviesMap = <int, Movie>{};
    for ( final movie in movies ) {
      tempMoviesMap[movie.id] = movie;
    }

    state = { ...state, ...tempMoviesMap };

    return movies;
  }

  Future<void> toogleFavorite( Movie movie ) async {
    await localStorageRespository.togggleFavoriteMovie(movie);

    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites){
      state.remove(movie.id);
      state = { ...state };
    } else {
      state = { ...state, movie.id: movie };
    }

  }


}