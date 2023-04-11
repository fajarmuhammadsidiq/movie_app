import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
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
