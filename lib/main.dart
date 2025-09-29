import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/controllers/navigation_controller.dart';
import 'core/widgets/main_navigation.dart';
import 'data/storage_service.dart';
import 'modules/home/controllers/home_controller.dart';
import 'modules/history/controllers/history_controller.dart';
import 'modules/settings/controllers/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage service
  await Get.putAsync(() => StorageService().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NavigationController());
    Get.put(HomeController());
    Get.put(HistoryController());
    Get.put(SettingsController());

    final StorageService storageService = Get.find<StorageService>();

    return GetMaterialApp(
      title: 'One Tap Journal',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: storageService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
