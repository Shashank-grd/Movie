import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final dynamic movie;
  const DetailsScreen({Key? key,required this.movie}) : super(key: key);
  @override
  _SquidGameDetailsScreenState createState() => _SquidGameDetailsScreenState();
}

class _SquidGameDetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Detail Screen",style: TextStyle(fontSize: 30),),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie['name'],
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _stripHtmlTags( widget.movie['summary'] ),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Genres: ${(widget.movie['genres'] as List<dynamic>)?.join(', ') }',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Status: ${widget.movie['status'] }',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  if (widget.movie['rating'] != null && widget.movie['rating']['average'] != null)
                    Text(
                      'Rating: ${widget.movie['rating']['average']}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                ],
              ),
            ),
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
          image: NetworkImage(widget.movie['image']?['original'] ?? 'https://placeholder.com/800x400'),
          fit: BoxFit.fill,
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
                  widget.movie['name'] ?? 'Movie',
                  style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  widget.movie['language'],
                  style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold),
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
  String _stripHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}