import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/tv_model.dart';

class TvPageController extends GetxController {
  String apiKey = "17bee6b7a59fa1098833391288283714";
  Future<TvModels> getDiscover() async {
    String url =
        "https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey&language=en-US&page=1";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    return TvModels.fromJson(data);
  }

  Future<TvModels> upComingMovie() async {
    String url =
        "https://api.themoviedb.org/3/tv/top_rated?api_key=${apiKey}&page=1";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    return TvModels.fromJson(data);
  }

  Future<TvModels> popularMovie() async {
    String url =
        "https://api.themoviedb.org/3/tv/on_the_air?api_key=$apiKey&language=en-US&page=1";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    return TvModels.fromJson(data);
  }
}
