import 'package:equatable/equatable.dart';
import 'package:news/app/core/usecase/usecase.dart';
import 'package:news/app/domain/entities/article_entity.dart';
import 'package:news/app/domain/repository/news_repository.dart';

// Encapsulates the specific business logic of getting top headlines.
class GetTopHeadlinesUseCase
    implements UseCase<List<ArticleEntity>, GetTopHeadlinesParams> {
  final NewsRepository _repository;

  GetTopHeadlinesUseCase(this._repository);

  @override
  Future<List<ArticleEntity>> call({required GetTopHeadlinesParams params}) {
    return _repository.getTopHeadlines(
      page: params.page,
      pageSize: params.pageSize,
      category: params.category,
    );
  }
}

// Parameters required for this specific UseCase
class GetTopHeadlinesParams extends Equatable {
  final int page;
  final int pageSize;
  final String category;

  const GetTopHeadlinesParams({
    required this.page,
    required this.pageSize,
    required this.category,
  });

  @override
  List<Object?> get props => [page, pageSize, category];
}

// Use case for searching news articles by query
class SearchNewsUseCase
    implements UseCase<List<ArticleEntity>, SearchNewsParams> {
  final NewsRepository _repository;

  SearchNewsUseCase(this._repository);

  @override
  Future<List<ArticleEntity>> call({required SearchNewsParams params}) {
    return _repository.searchNews(
      query: params.query,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

class SearchNewsParams extends Equatable {
  final String query;
  final int page;
  final int pageSize;

  const SearchNewsParams({
    required this.query,
    required this.page,
    required this.pageSize,
  });

  @override
  List<Object?> get props => [query, page, pageSize];
}
