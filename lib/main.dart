import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_app/app/controllers/page_controller_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  final pageController1 = Get.put(PageIndexController(), permanent: true);
  runApp(
    GetMaterialApp(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

final ThemeData myTheme = ThemeData(
  // Ganti font default di sini
  fontFamily: 'Poppins',
  // Lainnya pengaturan tema Anda
);
