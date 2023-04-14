import 'dart:convert';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/movie.dart';
import 'package:http/http.dart' as http;

class SeeAllNowPlayingController extends GetxController {
  //TODO: Implement SeeAllNowPlayingController

  final PagingController<int, Movie> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
      print(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await fetchMovies(pageKey);
      final isLastPage = newItems.isEmpty;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  String apiKey = "17bee6b7a59fa1098833391288283714";
  String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchMovies(int page) async {
    final url = Uri.parse(
        '$baseUrl/movie/now_playing?api_key=$apiKey&language=en-US&page=$page');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse =
          (json.decode(response.body) as Map<String, dynamic>)["results"];
      return jsonResponse
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
