import 'package:get/get.dart';

import '../controllers/tv_page_controller.dart';

class TvPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TvPageController>(
      () => TvPageController(),
    );
  }
}
