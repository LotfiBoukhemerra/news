// The abstract contract (interface) for data operations.
// The Domain layer defines what the app needs, not how it's fetched.
import 'package:news/app/domain/entities/article_entity.dart';

abstract class NewsRepository {
  Future<List<ArticleEntity>> getTopHeadlines({
    required int page,
    required int pageSize,
    required String category,
  });

  Future<List<ArticleEntity>> searchNews({
    required String query,
    required int page,
    required int pageSize,
  });
}
