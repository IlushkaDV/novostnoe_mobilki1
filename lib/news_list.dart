import 'package:flutter/material.dart';
import 'news_detail.dart';
import 'news_service.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final NewsService newsService = NewsService();
  bool isFullArticleVisible = false;
  String selectedArticleUrl = '';

  void openFullArticle(String url) {
    setState(() {
      isFullArticleVisible = true;
      selectedArticleUrl = url;
    });
  }

  void closeFullArticle() {
    setState(() {
      isFullArticleVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: isFullArticleVisible
          ? NewsDetail(url: selectedArticleUrl, onClose: closeFullArticle)
          : FutureBuilder(
        future: newsService.getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<News> newsList = snapshot.data as List<News>;

            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(12.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      newsList[index].title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        newsList[index].description,
                        style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        openFullArticle(newsList[index].url);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Read More',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
