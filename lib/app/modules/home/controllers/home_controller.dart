import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/data/noplaying_model.dart';
import 'package:movie_app/app/data/genre_model.dart';
import 'package:movie_app/app/data/popularMovie.dart';

import '../../../data/upComing_model.dart';

class HomeController extends GetxController {
  String apiKey = "17bee6b7a59fa1098833391288283714";
  Future<NowPlaying> getDiscover() async {
    String url =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&page=1";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    return NowPlaying.fromJson(data);
  }

  Future<GenreMovie> getGenreMovie() async {
    String url =
        "https://api.themoviedb.org/3/genre/movie/list?api_key=${apiKey}";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    return GenreMovie.fromJson(data);
  }

  Future<UpComingMovie> upComingMovie() async {
    String url =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=${apiKey}&page=2";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    return UpComingMovie.fromJson(data);
  }

  Future<PopularfMovie> popularMovie() async {
    String url =
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    print(data);
    return PopularfMovie.fromJson(data);
  }
}
