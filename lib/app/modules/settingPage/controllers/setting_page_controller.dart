import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/noplaying_model.dart';
import '../../../data/person_model.dart';
import 'package:http/http.dart' as http;

import '../../../data/tv_model.dart';
import '../../../data/tvdetail_model.dart';

class SettingPageController extends GetxController {
  //TODO: Implement SettingPageController

  String baseUrl = 'https://api.themoviedb.org/3';

  String apiKey = "17bee6b7a59fa1098833391288283714";
  Future<NowPlaying> recomTV(int id) async {
    String apiKey = "17bee6b7a59fa1098833391288283714";
    String url =
        "https://api.themoviedb.org/3/movie/$id/similar?api_key=$apiKey&language=en-US&page=1";
    var response = await http.get(Uri.parse(url));
    final data = json.decode(response.body) as Map<String, dynamic>;
    print(data);

    return NowPlaying.fromJson(data);
  }
}
