import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/const.dart';
import 'package:movie_app/app/routes/app_pages.dart';

import '../../../data/movie.dart';

import '../controllers/see_all_now_playing_controller.dart';

class SeeAllNowPlayingView extends GetView<SeeAllNowPlayingController> {
  const SeeAllNowPlayingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Now Playing Movies",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: PagedListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Movie>(
              itemBuilder: (context, item, index) {
            print(index);
            Movie data = item;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                child: Card(
                  color: Colors.black,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_NOW_PLAYING_PAGINATION,
                          arguments: data);
                    },
                    leading: Container(
                      height: 100,
                      width: 50,
                      color: Colors.red,
                      child: Image.network(
                          fit: BoxFit.cover,
                          '${Url.imageLw500}${item.posterPath}'),
                    ),
                    title: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.red, Colors.black])),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          item.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    subtitle: Text(
                      maxLines: 3,
                      item.overview,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
