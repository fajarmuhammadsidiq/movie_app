import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/noplaying_model.dart' as re;
import 'package:movie_app/app/data/noplaying_model.dart%20';

import '../../../data/const.dart';
import '../../../data/movie.dart';
import '../../../data/popularMovie.dart';
import '../controllers/see_all_now_playing_controller.dart';

class SeeAllNowPlayingView extends StatefulWidget {
  const SeeAllNowPlayingView({Key? key}) : super(key: key);

  @override
  State<SeeAllNowPlayingView> createState() => _SeeAllNowPlayingViewState();
}

class _SeeAllNowPlayingViewState extends State<SeeAllNowPlayingView> {
  final controller = Get.find<SeeAllNowPlayingController>();

  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await controller.fetchMovies(pageKey);
      final isLastPage = newItems.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("wow"),
        ),
        body: PagedListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          pagingController: _pagingController,
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
