import 'package:equatable/equatable.dart';

// The core business object (Entity). Independent of data sources.
class ArticleEntity extends Equatable {
  final String? sourceName;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  const ArticleEntity({
    this.sourceName,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  // Equatable helps in comparing objects, useful for testing and state management
  @override
  List<Object?> get props => [
    sourceName,
    author,
    title,
    description,
    url,
    urlToImage,
    publishedAt,
    content,
  ];
}
