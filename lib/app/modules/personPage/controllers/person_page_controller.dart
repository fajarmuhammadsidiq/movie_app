import 'dart:convert';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/person_model.dart';
import 'package:http/http.dart' as http;

class PersonPageController extends GetxController {
  final PagingController<int, PersonModel> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
      print(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await fetchPerson(pageKey);
      final isLastPage = newItems.isEmpty;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  String apiKey = "17bee6b7a59fa1098833391288283714";
  String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<PersonModel>> fetchPerson(int page) async {
    final url = Uri.parse(
        '$baseUrl/person/popular?api_key=$apiKey&language=en-US&page=$page');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse =
          (json.decode(response.body) as Map<String, dynamic>)["results"];
      return jsonResponse.map((e) => PersonModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
