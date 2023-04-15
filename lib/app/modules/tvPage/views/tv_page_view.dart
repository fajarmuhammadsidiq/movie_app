import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tv_page_controller.dart';

class TvPageView extends GetView<TvPageController> {
  const TvPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TvPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TvPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
