import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/person_model.dart';
import 'package:http/http.dart' as http;

class SettingPageController extends GetxController {
  //TODO: Implement SettingPageController

  String apiKey = "17bee6b7a59fa1098833391288283714";
  String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<PersonModel>> fetchPerson(int page) async {
    final url = Uri.parse(
        '$baseUrl/person/popular?api_key=$apiKey&language=en-US&page=$page');
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
