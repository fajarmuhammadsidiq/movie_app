import 'package:get/get.dart';

import '../controllers/favorites_page_controller.dart';

class FavoritesPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesPageController>(
      () => FavoritesPageController(),
    );
  }
}
