import 'package:get/get.dart';

import '../controllers/detail_now_playing_pagination_controller.dart';

class DetailNowPlayingPaginationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailNowPlayingPaginationController>(
      () => DetailNowPlayingPaginationController(),
    );
  }
}
