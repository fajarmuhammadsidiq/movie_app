import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/movie.dart';
import '../../../data/noplaying_model.dart';
import 'package:http/http.dart' as http;

class SeeAllNowPlayingController extends GetxController {
  //TODO: Implement SeeAllNowPlayingController
  String apiKey = "17bee6b7a59fa1098833391288283714";
  static const baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchMovies(int page) async {
    final url = Uri.parse(
        '$baseUrl/movie/now_playing?api_key=$apiKey&language=en-US&page=$page');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> results = jsonResponse['results'];
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
