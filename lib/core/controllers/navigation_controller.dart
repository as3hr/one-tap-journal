import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void goToHome() => changeTab(0);
  void goToHistory() => changeTab(1);
  void goToSettings() => changeTab(2);
}
