import 'package:get/get.dart';
import 'package:news/app/data/repository/news_repository_impl.dart';
import 'package:news/app/domain/repository/news_repository.dart';
import 'package:news/app/domain/usecases/get_top_headlines.dart';
import 'package:news/app/presentation/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Repositories: Bind the implementation (Data layer) to the abstraction (Domain layer)
    // NewsApiService is already provided by GlobalBindings
    Get.lazyPut<NewsRepository>(() => NewsRepositoryImpl(Get.find()));

    // Use Cases
    Get.lazyPut<GetTopHeadlinesUseCase>(
      () => GetTopHeadlinesUseCase(Get.find<NewsRepository>()),
    );
    Get.lazyPut<SearchNewsUseCase>(
      () => SearchNewsUseCase(Get.find<NewsRepository>()),
    );

    // Controllers: Inject the UseCase into the controller
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<GetTopHeadlinesUseCase>()),
    );
  }
}
