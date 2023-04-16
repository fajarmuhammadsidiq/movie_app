import 'package:get/get.dart';

import '../controllers/webview_movies_controller.dart';

class WebviewMoviesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebviewMoviesController>(
      () => WebviewMoviesController(),
    );
  }
}
