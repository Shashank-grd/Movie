import 'package:flutter/material.dart';
import 'package:movie/Screen/detail_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> searchResults = [];

  Future<void> searchMovies(String query) async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onSubmitted: searchMovies,
          decoration: InputDecoration(
            hintText: 'Search movies...',
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white,fontSize: 25),

        ),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final movie = searchResults[index]['show'];
          return ListTile(
            leading: movie['image'] != null
                ? Image.network(movie['image']['medium'])
                : Icon(Icons.movie),
            title: Text(movie['name']),
            subtitle: Text(movie['summary'] != null
                ? _stripHtmlTags(movie['summary'])
                : 'No summary available',
           maxLines: 2,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(movie: movie),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _stripHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}

