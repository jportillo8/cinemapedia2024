import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/infrastructure/models/models.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
            : 'https://cdn.pixabay.com/photo/2016/11/16/11/29/coupon-1828620_1280.png',
        character: cast.character,
      );
}
