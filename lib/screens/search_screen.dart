import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_card.dart';
import 'dart:convert';

import '../models/movie.dart';
// Make sure the path is correct
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List<Movie> searchResults = [];
  TextEditingController searchController = TextEditingController();

  Future<void> searchMovies(String query) async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      setState(() {
        searchResults = jsonData.map((data) => Movie.fromJson(data['show'])).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Movies")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,  // Background color of the search bar
                borderRadius: BorderRadius.circular(30),  // Circular radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                    blurRadius: 6,
                    offset: Offset(3, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onSubmitted: searchMovies,
                decoration: InputDecoration(
                  hintText: 'Search for movies...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetailsScreen(movie: movie)),
                  ),
                  child: MovieCard(movie: movie),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
