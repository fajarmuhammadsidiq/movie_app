import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/genre_model.dart';
import '../controllers/genres_page_controller.dart';

class GenresPageView extends GetView<GenresPageController> {
  const GenresPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Genre genres = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('GenresPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GenresPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
