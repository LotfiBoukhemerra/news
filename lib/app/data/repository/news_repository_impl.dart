import 'package:news/app/data/datasources/remote/news_api_service.dart';
import 'package:news/app/domain/entities/article_entity.dart';
import 'package:news/app/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiService _apiService;

  NewsRepositoryImpl(this._apiService);

  @override
  Future<List<ArticleEntity>> getTopHeadlines({
    required int page,
    required int pageSize,
    required String category,
  }) async {
    try {
      final response = await _apiService.getTopHeadlines(
        page: page,
        pageSize: pageSize,
        category: category,
      );
      // ArticleModel extends ArticleEntity, so we can return the list directly.
      // This bridges the Data layer (Models) to the Domain layer (Entities).
      return response.articles;
    } catch (e) {
      // Propagate the exception up to the UseCase/Controller
      rethrow;
    }
  }

  @override
  Future<List<ArticleEntity>> searchNews({
    required String query,
    required int page,
    required int pageSize,
  }) async {
    throw UnimplementedError();
  }
}
