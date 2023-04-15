import 'package:get/get.dart';

import '../controllers/person_page_controller.dart';

class PersonPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonPageController>(
      () => PersonPageController(),
    );
  }
}
