import 'package:get/get.dart';

import '../controllers/webview_t_v_controller.dart';

class WebviewTVBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebviewTVController>(
      () => WebviewTVController(),
    );
  }
}
