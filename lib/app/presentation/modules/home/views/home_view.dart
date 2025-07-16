import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:news/app/presentation/modules/home/widgets/article_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News light'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Get.snackbar(
                "Coming Soon",
                "Search functionality is not yet implemented.",
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildCategoryFilter(context),
            Expanded(child: _buildNewsList()),
          ],
        ),
      ),
    );
  }

  // Widget for the horizontal category selector
  Widget _buildCategoryFilter(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return Obx(() {
            final isSelected = controller.selectedCategory.value == category;
            return GestureDetector(
              onTap: () => controller.changeCategory(category),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    category.capitalizeFirst!,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  // Widget for the main news list with Pull-to-Refresh and Infinite Scroll
  Widget _buildNewsList() {
    return Obx(() {
      // Show loading indicator only on initial load or category change
      if (controller.isLoading.value && controller.articles.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      // Show empty state
      if (controller.articles.isEmpty) {
        return const Center(
          child: Text("No articles found for this category."),
        );
      }

      // The SmartRefresher handles both pull-to-refresh and load-more (pagination)
      return SmartRefresher(
        controller: controller.refreshController,
        enablePullDown: true,
        enablePullUp: true, // Enables the footer for infinite scroll
        onRefresh: () => controller.fetchNews(isRefresh: true),
        onLoading: () => controller.loadMoreNews(),
        header: const WaterDropHeader(), // A nice pull-to-refresh animation
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.loading) {
              body = const CircularProgressIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed! Click retry.");
            } else if (mode == LoadStatus.noMore) {
              body = const Text("You've reached the end.");
            } else {
              body = const SizedBox.shrink(); // Idle state
            }
            return SizedBox(height: 55.0, child: Center(child: body));
          },
        ),
        child: ListView.builder(
          itemCount: controller.articles.length,
          itemBuilder: (context, index) {
            final article = controller.articles[index];
            return ArticleCard(
              article: article,
              onTap: () => controller.openArticleUrl(article.url),
            );
          },
        ),
      );
    });
  }
}
