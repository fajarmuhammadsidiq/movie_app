import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../data/detail_model.dart';
import '../../../data/video_model.dart';

class DetailNowPlayingPaginationController extends GetxController {
  Future<VideoModel> trailerMovie(String id) async {
    String apiKey = "17bee6b7a59fa1098833391288283714";
    String url =
        "https://api.themoviedb.org/3/movie/$id/videos?api_key=$apiKey&language=en-US";
    var response = await http.get(Uri.parse(url));
    final data = json.decode(response.body) as Map<String, dynamic>;

    return VideoModel.fromJson(data);
  }

  Future<DetailMovie> detailMovie(int id) async {
    String apiKey = "17bee6b7a59fa1098833391288283714";
    String url =
        "https://api.themoviedb.org/3/movie/${id}?api_key=${apiKey}&language=en-US";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    return DetailMovie.fromJson(data);
  }
}
