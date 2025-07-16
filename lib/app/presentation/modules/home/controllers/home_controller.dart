import 'package:get/get.dart';
import 'package:news/app/domain/entities/article_entity.dart';
import 'package:news/app/domain/usecases/get_top_headlines.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class HomeController extends GetxController {
  // Controller depends only on the UseCase (Domain layer)
  final GetTopHeadlinesUseCase _getTopHeadlinesUseCase;
  final SearchNewsUseCase _searchNewsUseCase = Get.find<SearchNewsUseCase>();

  HomeController(this._getTopHeadlinesUseCase);

  // Reactive variables (Observable)
  var articles = <ArticleEntity>[].obs;
  var isLoading = true.obs;
  var selectedCategory = 'general'.obs;
  var searchQuery = ''.obs;
  var isSearching = false.obs;

  // Available categories for filtering
  final List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  // Pagination variables
  int _page = 1;
  final int _pageSize = 50; // Requirement: 50 articles per page
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  Timer? _autoRefreshTimer;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      fetchNews(isRefresh: true);
    });
  }

  // Main function to fetch news (used for initial load, refresh, and load more)
  Future<void> fetchNews({bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 1;
      isLoading.value = true;
      // Reset the pagination footer state
      refreshController.resetNoData();
    }

    try {
      List<ArticleEntity> newArticles;
      if (isSearching.value && searchQuery.value.isNotEmpty) {
        final params = SearchNewsParams(
          query: searchQuery.value,
          page: _page,
          pageSize: _pageSize,
        );
        newArticles = await _searchNewsUseCase(params: params);
      } else {
        final params = GetTopHeadlinesParams(
          page: _page,
          pageSize: _pageSize,
          category: selectedCategory.value,
        );
        newArticles = await _getTopHeadlinesUseCase(params: params);
      }

      if (isRefresh) {
        articles.value = newArticles; // Replace list on refresh
      } else {
        articles.addAll(newArticles); // Add to list on load more
      }

      // Update Refresh/Load status
      if (isRefresh) refreshController.refreshCompleted();

      // Check if we received fewer articles than requested, indicating the end of the list
      if (newArticles.length < _pageSize) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    } catch (e) {
      // Error handling
      Get.snackbar(
        'Error',
        'Failed to fetch news: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
      if (isRefresh) {
        refreshController.refreshFailed();
      } else {
        refreshController.loadFailed();
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Handler for loading the next page
  Future<void> loadMoreNews() async {
    _page++;
    await fetchNews();
  }

  // Handler for changing the news category
  void changeCategory(String category) {
    if (selectedCategory.value != category) {
      selectedCategory.value = category;
      isSearching.value = false;
      searchQuery.value = '';
      fetchNews(isRefresh: true);
    }
  }

  // Search for news articles
  Future<void> searchNews(String query) async {
    searchQuery.value = query;
    isSearching.value = query.isNotEmpty;
    _page = 1;
    isLoading.value = true;
    refreshController.resetNoData();
    await fetchNews(isRefresh: true);
  }

  // Clear search and return to normal headlines
  void clearSearch() {
    searchQuery.value = '';
    isSearching.value = false;
    _page = 1;
    fetchNews(isRefresh: true);
  }

  // Utility to open the article URL
  Future<void> openArticleUrl(String? url) async {
    if (url == null || url.isEmpty) {
      Get.snackbar(
        'Error',
        'Article URL is not available.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final uri = Uri.parse(url);
    // Open in an external application (browser)
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    refreshController.dispose();
    _autoRefreshTimer?.cancel();
    super.onClose();
  }
}
