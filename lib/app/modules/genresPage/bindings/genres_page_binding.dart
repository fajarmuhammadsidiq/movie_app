import 'package:get/get.dart';

import '../controllers/genres_page_controller.dart';

class GenresPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenresPageController>(
      () => GenresPageController(),
    );
  }
}
