import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/noplaying_model.dart' as re;
import 'package:movie_app/app/data/noplaying_model.dart%20';

import '../../../data/const.dart';
import '../../../data/movie.dart';
import '../../../data/popularMovie.dart';
import '../controllers/see_all_now_playing_controller.dart';

class SeeAllNowPlayingView extends GetView<SeeAllNowPlayingController> {
  const SeeAllNowPlayingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("wow"),
        ),
        body: PagedListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Movie>(
            itemBuilder: (context, item, index) => Card(
              child: ListTile(
                leading: Image.network(
                    'https://image.tmdb.org/t/p/w92${item.posterPath}'),
                title: Text(item.title),
                subtitle: Text(maxLines: 3, item.overview),
              ),
            ),
          ),
        ));
  }
}
