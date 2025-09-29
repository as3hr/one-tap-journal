import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../controllers/navigation_controller.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/history/views/history_view.dart';
import '../../modules/settings/views/settings_view.dart';

class MainNavigation extends GetView<NavigationController> {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeView(),
      const HistoryView(),
      const SettingsView(),
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: pages,
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTab,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.lightBlueColor,
        unselectedItemColor: AppColors.greyColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history_rounded),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      )),
    );
  }
}
