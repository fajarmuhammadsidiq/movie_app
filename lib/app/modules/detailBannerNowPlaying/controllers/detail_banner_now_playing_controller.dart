import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/data/video_model.dart';

class DetailBannerNowPlayingController extends GetxController {
  Future<VideoModel> trailerMovie(String id) async {
    String apiKey = "17bee6b7a59fa1098833391288283714";
    String url =
        "https://api.themoviedb.org/3/movie/$id/videos?api_key=$apiKey&language=en-US";
    var response = await http.get(Uri.parse(url));
    final data = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      print("HIT API SUKSES");
    } else {
      print("Hit API Gagal");
    }
    return VideoModel.fromJson(data);
  }
}
