import 'package:get/get.dart';

import '../controllers/search_detail_controller.dart';

class SearchDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchDetailController>(
      () => SearchDetailController(),
    );
  }
}
