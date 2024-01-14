import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credit_response.dart';

class ActorMapper {

  static Actor castToEntity ( Cast cast ) => Actor(
    id: cast.id,
    character: cast.character,
    name: cast.name,
    profilePath: cast.profilePath != null ? 'https://image.tmdb.org/t/p/w500${ cast.profilePath }': 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
  );
}