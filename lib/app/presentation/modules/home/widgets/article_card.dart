import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/app/domain/entities/article_entity.dart';

class ArticleCard extends StatelessWidget {
  // The widget depends on the Entity (Domain layer), not the Model (Data layer)
  final ArticleEntity article;
  final VoidCallback onTap;

  const ArticleCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      clipBehavior:
          Clip.antiAlias, // Ensures the image respects the card's border radius
      child: InkWell(
        // InkWell provides the ripple effect on tap
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImage(context), _buildContent()],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article.urlToImage ?? '',
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
      // Placeholder while loading
      placeholder: (context, url) => Container(
        height: 200,
        color: Colors.grey[700],
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      // Error widget if image fails to load or urlToImage is null/invalid
      errorWidget: (context, url, error) => Container(
        height: 200,
        color: Colors.grey[800],
        child: const Icon(Icons.broken_image, color: Colors.grey, size: 50),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            article.title ?? 'No Title Available',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          // Source and Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  article.sourceName ?? 'Unknown Source',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                _formatDateTime(article.publishedAt),
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    // Using intl package for formatting
    return DateFormat('MMM d, yyyy HH:mm').format(dateTime);
  }
}
