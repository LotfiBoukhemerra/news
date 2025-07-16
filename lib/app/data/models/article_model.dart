import 'package:news/app/domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    super.sourceName,
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });

  // Factory constructor to create an ArticleModel from a JSON map
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      // News API returns source as a nested object { 'id': ..., 'name': ... }
      sourceName: json['source']?['name'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      // Safely parse the ISO 8601 date string
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'])
          : null,
      content: json['content'],
    );
  }
}
