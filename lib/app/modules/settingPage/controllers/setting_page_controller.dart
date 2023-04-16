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
  Future<List<PersonModel>> fetchPerson() async {
    final url = Uri.parse(
        '$baseUrl/person/popular?api_key=$apiKey&language=en-US&page=4');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse =
          (json.decode(response.body) as Map<String, dynamic>)["results"];
      print(jsonResponse);
      return jsonResponse.map((e) => PersonModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
