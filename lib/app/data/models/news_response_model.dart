import 'package:news/app/data/models/article_model.dart';

class NewsResponseModel {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  NewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    // Map the list of article JSON objects to a list of ArticleModel objects
    var articlesList = (json['articles'] as List<dynamic>?) ?? [];
    List<ArticleModel> articles = articlesList
        .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return NewsResponseModel(
      status: json['status'] ?? 'error',
      totalResults: json['totalResults'] ?? 0,
      articles: articles,
    );
  }
}
