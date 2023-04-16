import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/page_controller_controller.dart';
import '../controllers/favorites_page_controller.dart';

class FavoritesPageView extends GetView<FavoritesPageController> {
  const FavoritesPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PageController1 = Get.find<PageIndexController>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('FavoritesPageView'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'FavoritesPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: FloatingNavbar(
        selectedItemColor: Colors.white,
        selectedBackgroundColor: Colors.red,
        backgroundColor: const Color.fromARGB(255, 48, 47, 47),
        onTap: (int i) {
          PageController1.changeIndexPage(i);
        },
        currentIndex: PageController1.pageIndex.value,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
          FloatingNavbarItem(icon: Icons.favorite_border, title: 'Favorite'),
          FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
        ],
      ),
    );
  }
}
