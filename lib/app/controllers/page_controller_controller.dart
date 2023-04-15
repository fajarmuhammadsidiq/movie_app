import 'package:get/get.dart';

import '../routes/app_pages.dart';

class PageIndexController extends GetxController {
  //TODO: Implement PageControllerController

  RxInt pageIndex = 0.obs;

  void changeIndexPage(int i) {
    switch (i) {
      case 0:
        pageIndex.value = i;
        print("masuk dashboard");
        Get.offAllNamed(Routes.HOME);
        break;
      case 1:
        pageIndex.value = i;
        print("Explore");
        Get.offAllNamed(Routes.EXPLORE_PAGE);
        break;
      case 2:
        pageIndex.value = i;
        print("Favorites");
        Get.offAllNamed(Routes.FAVORITES_PAGE);
        break;
      case 3:
        pageIndex.value = i;
        print("Setting");
        Get.offAllNamed(Routes.SETTING_PAGE);
        break;
      default:
    }
  }
}
