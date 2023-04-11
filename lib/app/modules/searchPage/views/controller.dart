import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/search_mode.dart';

class SearchController extends GetxController {
  Future<List<dynamic>> searchMovies(String query) async {
    String apiKey = "17bee6b7a59fa1098833391288283714";
    final url =
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=en-US&query=$query&page=1&include_adult=false';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];
      return results;
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
