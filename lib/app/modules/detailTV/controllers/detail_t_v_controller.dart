import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/data/tv_model.dart';

import '../../../data/tvdetail_model.dart';
import '../../../data/video_model.dart';

class DetailTVController extends GetxController {
  Future<TvDetails> detailTV(int id) async {
    String apiKey = "17bee6b7a59fa1098833391288283714";
    String url =
        "https://api.themoviedb.org/3/tv/$id?api_key=$apiKey&language=en-US";
    var response = await http.get(Uri.parse(url));
    final data = json.decode(response.body) as Map<String, dynamic>;
    print(data);

    return TvDetails.fromJson(data);
  }

  Future<TvModels> recomTV(int id) async {
    String apiKey = "17bee6b7a59fa1098833391288283714";
    String url =
        "https://api.themoviedb.org/3/tv/$id/recommendations?api_key=$apiKey&language=en-US&page=1";
    var response = await http.get(Uri.parse(url));
    final data = json.decode(response.body) as Map<String, dynamic>;
    print(data);

    return TvModels.fromJson(data);
  }

  Future<VideoModel> trailerMovie(String id) async {
    String apiKey = "17bee6b7a59fa1098833391288283714";
    String url =
        "https://api.themoviedb.org/3/tv/$id/videos?api_key=$apiKey&language=en-US";
    var response = await http.get(Uri.parse(url));
    final data = json.decode(response.body) as Map<String, dynamic>;

    return VideoModel.fromJson(data);
  }
}
