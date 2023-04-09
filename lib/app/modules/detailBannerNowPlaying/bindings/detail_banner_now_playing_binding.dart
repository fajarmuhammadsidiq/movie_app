import 'package:get/get.dart';

import '../controllers/detail_banner_now_playing_controller.dart';

class DetailBannerNowPlayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailBannerNowPlayingController>(
      () => DetailBannerNowPlayingController(),
    );
  }
}
