import 'package:cinemapedia/config/constants/environments.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actors_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credit_response.dart';
import 'package:dio/dio.dart';

class ActorsDataSourceImpl extends ActorsDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        "api_key": Enviroments.moviedDbKey,
        "language": "es-MX"
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final castData = CreditResponse.fromJson(response.data);

    final actors = castData.cast.map<Actor>((actor) {
      return ActorMapper.castToEntity(actor);
    }).toList();

    return actors;
  }
}
