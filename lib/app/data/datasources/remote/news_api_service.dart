import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/app/data/models/news_response_model.dart';

class NewsApiService {
  final Dio _dio;
  // Safely retrieve the API key loaded in main.dart
  final String _apiKey = dotenv.env['NEWS_API_KEY']!;

  NewsApiService(this._dio);

  Future<NewsResponseModel> getTopHeadlines({
    required int page,
    required int pageSize,
    String category = 'general',
  }) async {
    try {
      final response = await _dio.get(
        '/top-headlines',
        queryParameters: {
          'country': 'us', // Defaulting to US news for top headlines
          'category': category,
          'page': page,
          'pageSize': pageSize,
          'apiKey': _apiKey,
        },
      );
      // Dio automatically parses JSON if the content-type is correct
      return NewsResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      // Handle Dio-specific errors (e.g., network issues, 401 unauthorized)
      if (kDebugMode) {
        print("DioError: ${e.message}");
      }
      // Robust error handling should be implemented here
      throw Exception(
        'Failed to load news: ${e.response?.data['message'] ?? e.message}',
      );
    } catch (e) {
      // Handle other errors
      if (kDebugMode) {
        print("Error: ${e.toString()}");
      }
      throw Exception('An unexpected error occurred');
    }
  }

  Future<NewsResponseModel> searchNews({
    required String query,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await _dio.get(
        '/everything',
        queryParameters: {
          'q': query,
          'page': page,
          'pageSize': pageSize,
          'apiKey': _apiKey,
          'language': 'en',
        },
      );
      return NewsResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (kDebugMode) {
        print("DioError:  [31m");
        print(e.message);
      }
      throw Exception(
        'Failed to search news:  [31m${e.response?.data['message'] ?? e.message}',
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error: ");
        print(e.toString());
      }
      throw Exception('An unexpected error occurred');
    }
  }
}
