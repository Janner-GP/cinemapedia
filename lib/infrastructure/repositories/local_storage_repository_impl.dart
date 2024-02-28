import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {

  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getFavoriteMovies({int pagelimit = 13, offset = 0}) {
    return datasource.getFavoriteMovies(pagelimit: pagelimit, offset: offset);
  }

  @override
  Future<bool> isFavoriteMovie(int movieId) {
    return datasource.isFavoriteMovie(movieId);
  }

  @override
  Future<void> togggleFavoriteMovie(Movie movie) {
    return datasource.togggleFavoriteMovie(movie);
  }

}