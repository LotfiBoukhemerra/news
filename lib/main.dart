import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:news/app/presentation/routes/app_pages.dart';
import 'package:news/global_bindings.dart';

Future<void> main() async {
  // Ensure all bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News light',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF00A99D), // Teal Accent
        scaffoldBackgroundColor: const Color(0xFF121212), // Dark Background
        cardColor: const Color(0xFF1E1E1E), // Dark Card
        appBarTheme: const AppBarTheme(
          color: Color(0xFF1E1E1E),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Apply primary color to the progress indicator
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF00A99D),
        ),
      ),
      initialBinding: GlobalBindings(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
