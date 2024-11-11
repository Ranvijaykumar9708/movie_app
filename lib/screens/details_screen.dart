import 'package:flutter/material.dart';
import '../models/movie.dart';

class DetailsScreen extends StatelessWidget {
  final Movie movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Column(
        children: [
          Image.network(movie.image,),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(child: Text(movie.title, style: TextStyle(fontSize: 20))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(movie.summary),
          ),
          // Additional details here if needed
        ],
      ),
    );
  }
}
