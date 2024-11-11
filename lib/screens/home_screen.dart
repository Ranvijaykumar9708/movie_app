import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_card.dart';
import 'package:movie_app/profile/login.dart';
import 'package:movie_app/profile/signup.dart';
import 'dart:convert';

import 'details_screen.dart';
import 'search_screen.dart';
// Import LoginPage
// Import SignUpPage
import '../models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      setState(() {
        movies = jsonData.map((data) => Movie.fromJson(data['show'])).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen())),
          child: Text("Search Movies"),
        ),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailsScreen(movie: movie)),
            ),
            child: MovieCard(movie: movie),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen()));
          } else if (index == 2) {
            // Show Profile options
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.login),
                        title: Text("Login"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.app_registration),
                        title: Text("Sign Up"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
