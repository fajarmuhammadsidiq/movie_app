import 'package:get/get.dart';

import '../controllers/detail_t_v_controller.dart';

class DetailTVBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTVController>(
      () => DetailTVController(),
    );
  }
}
