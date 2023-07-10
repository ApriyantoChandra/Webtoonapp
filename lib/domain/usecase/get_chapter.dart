import 'package:fpdart/fpdart.dart';
import 'package:webtoon_application_1/domain/repositories/comic_repository.dart';
import '../../utils/failure.dart';
import '../entities/chapter.dart';

class GetChapter {
  final ComicRepository repository;

  GetChapter(this.repository);

  Future<Either<Failure, Chapter>> execute(String param) async {
    return await repository.getChapter(param);
  }
}
