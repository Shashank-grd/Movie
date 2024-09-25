import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie/Screen/detail_screen.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> movies = [];
  List<dynamic> tvShows = [];
  List<dynamic> mobileGames = [];

  @override
  void initState() {
    super.initState();
    fetchContent();
  }

  Future<void> fetchContent() async {
    final moviesResponse = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    final tvShowsResponse = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=drama'));
    if (moviesResponse.statusCode == 200 && tvShowsResponse.statusCode == 200) {
      setState(() {
        movies = json.decode(moviesResponse.body);
        tvShows = json.decode(tvShowsResponse.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/quadb.png",height: 50),
        actions: [
          IconButton(icon: Icon(Icons.file_download), onPressed: () {}),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeaturedContent(),
            _buildContentSection('US TV Dramas', tvShows),
            _buildContentSection('Indian Movies', movies),
          ],
        ),
      ),

    );
  }

  Widget _buildFeaturedContent() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://static.tvmaze.com/uploads/images/original_untouched/425/1064746.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ALL American',
                  style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Suspenseful • Exciting • Thriller • Madrid • TV',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.play_arrow),
                      label: Text('Play'),
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Colors.white),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      label: Text('My List'),
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.grey[800]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(String title, List<dynamic> content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Text('See all >', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: content.length,
            itemBuilder: (context, index) {
              final item = content[index]['show'];
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(movie: item),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                           (item['image']?['medium'] ?? "data:image/jpeg;base64,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"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}