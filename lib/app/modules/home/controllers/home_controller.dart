import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/data/discover_model.dart';

class HomeController extends GetxController {
  String apiKey = "17bee6b7a59fa1098833391288283714";
  Future<DiscoverModel> getDiscover() async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?page=1&api_key=${apiKey}&sort_by=popularity.desc";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    print(data);
    return DiscoverModel.fromJson(data);
  }
}
