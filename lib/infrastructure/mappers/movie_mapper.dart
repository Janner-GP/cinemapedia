import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie moviedbToEntity( MovieMovieDB movieDB ) => Movie(
    adult: movieDB.adult,
    backdropPath: (movieDB.backdropPath != null) ? 'https://image.tmdb.org/t/p/w500${ movieDB.backdropPath }' : 'https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg',
    genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
    id: movieDB.id,
    originalLanguage: movieDB.originalLanguage,
    originalTitle: movieDB.originalTitle,
    overview: movieDB.overview,
    popularity: movieDB.popularity,
    posterPath: (movieDB.posterPath != null) ? 'https://image.tmdb.org/t/p/w500${ movieDB.backdropPath }' : 'no-poster',
    releaseDate: movieDB.releaseDate,
    title: movieDB.title,
    video: movieDB.video,
    voteAverage: movieDB.voteAverage,
    voteCount: movieDB.voteCount
  );


  static Movie movieDetailsToEntity( MovieDetail movie ) => Movie(
    adult: movie.adult,
    backdropPath: (movie.backdropPath != null) ? 'https://image.tmdb.org/t/p/w500${ movie.backdropPath }' : 'https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg',
    genreIds: movie.genres.map((e) => e.name).toList(),
    id: movie.id,
    originalLanguage: movie.originalLanguage,
    originalTitle: movie.originalTitle,
    overview: movie.overview,
    popularity: movie.popularity,
    posterPath: (movie.posterPath != null) ? 'https://image.tmdb.org/t/p/w500${ movie.backdropPath }' : 'https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg',
    releaseDate: movie.releaseDate,
    title: movie.title,
    video: movie.video,
    voteAverage: movie.voteAverage,
    voteCount: movie.voteCount
  );
}