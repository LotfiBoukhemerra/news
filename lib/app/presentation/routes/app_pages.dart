import 'package:get/get.dart';
import 'package:news/app/presentation/modules/home/bindings/home_binding.dart';
import 'package:news/app/presentation/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      // Bindings ensure dependencies are injected when the route is loaded
      binding: HomeBinding(),
    ),
  ];
}
