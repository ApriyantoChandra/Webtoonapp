import 'package:fpdart/fpdart.dart';
import 'package:webtoon_application_1/domain/entities/comic.dart';
import 'package:webtoon_application_1/domain/repositories/comic_repository.dart';
import 'package:webtoon_application_1/utils/failure.dart';

class GetComic {
  final ComicRepository repository;

  GetComic(this.repository);

  Future<Either<Failure, List<Comic>>> execute() {
    return repository.getComics();
  }
}
