import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:movie_app/app/modules/searchPage/views/controller.dart';

import '../../../routes/app_pages.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = Get.put(SearchController());
  final _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  Future<void> _searchMovies(String query) async {
    try {
      final results = await controller.searchMovies(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      print('Error searching movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          style: TextStyle(color: Colors.white),
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search movies',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          onSubmitted: (query) => _searchMovies(query),
        ),
      ),
      body: _searchResults.isEmpty
          ? const Center(child: Text('No results found'))
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> movie = _searchResults[index];
                return ListTile(
                  onTap: () {
                    Get.toNamed(Routes.SEARCH_DETAIL, arguments: movie);
                  },
                  title: Text(
                    "${movie['title']} | ${movie['release_date']}",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Row(
                    children: [
                      Text("Rating :", style: TextStyle(color: Colors.white)),
                      Icon(
                        Icons.star_rate_rounded,
                        color: Color.fromARGB(255, 253, 228, 0),
                      ),
                      Text("${movie['vote_average']}",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  leading: Container(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.error),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
