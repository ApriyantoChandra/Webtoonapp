import 'package:fpdart/fpdart.dart';
import 'package:webtoon_application_1/domain/entities/detail_comic.dart';
import 'package:webtoon_application_1/domain/repositories/comic_repository.dart';
import 'package:webtoon_application_1/utils/failure.dart';

class GetDetailComic {
  final ComicRepository repository;

  GetDetailComic(this.repository);

  Future<Either<Failure, DetailComic>> execute(String param) async {
    return await repository.getDetailComic(param);
  }
}
