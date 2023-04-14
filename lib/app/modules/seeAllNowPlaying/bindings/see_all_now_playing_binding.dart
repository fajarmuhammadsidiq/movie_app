import 'package:get/get.dart';

import '../controllers/see_all_now_playing_controller.dart';

class SeeAllNowPlayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeeAllNowPlayingController>(
      () => SeeAllNowPlayingController(),
    );
  }
}
