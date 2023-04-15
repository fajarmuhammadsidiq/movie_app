import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/app/routes/app_pages.dart';
import '../../../controllers/page_controller_controller.dart';
import '../controllers/explore_page_controller.dart';
import 'explore_widget.dart';

class ExplorePageView extends GetView<ExplorePageController> {
  const ExplorePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PageController1 = Get.find<PageIndexController>();
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Explore',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            ExploreWidget(
                label: "POPULAR PERSON",
                backdrop: "assets/person.jpg",
                page: Routes.PERSON_PAGE),
            SizedBox(height: 20),
            ExploreWidget(
                label: "TV SERIES",
                backdrop: "assets/tv.jpg",
                page: Routes.TV_PAGE),
            SizedBox(height: 20),
            ExploreWidget(label: "MOVIE SERIES", backdrop: "assets/movie.jpg"),
          ],
        ),
      ),
      bottomNavigationBar: FloatingNavbar(
        selectedItemColor: Colors.white,
        selectedBackgroundColor: Colors.red,
        backgroundColor: Color.fromARGB(255, 48, 47, 47),
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
