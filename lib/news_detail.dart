import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatelessWidget {
  final String url;
  final VoidCallback onClose;

  NewsDetail({required this.url, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Full Article',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onClose,
        ),
        backgroundColor: Colors.indigo,
      ),
      body: WebView(
        initialUrl: url,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onClose,
        tooltip: 'Close',
        child: Icon(Icons.close),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}