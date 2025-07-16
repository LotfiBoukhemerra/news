import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:news/app/data/datasources/remote/news_api_service.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    // Core Networking Setup
    Get.put<Dio>(Dio(BaseOptions(baseUrl: 'https://newsapi.org/v2')));
    // Core Data Source
    Get.put<NewsApiService>(NewsApiService(Get.find<Dio>()));
  }
}
