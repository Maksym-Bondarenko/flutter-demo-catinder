import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'cats_page.dart';
import 'favorites_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter First App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      home: MyHomePage(title: 'CATinder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();

  static _MyHomePageState? of(BuildContext context) {
    return context.findAncestorStateOfType();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  List images = [];
  List favorites = [];

  @override
  void initState() {
    super.initState();

    http.get(
      Uri.parse("https://api.thecatapi.com/v1/images/search?format=json&mime_types=jpg&limit=100"),
      headers: {"x-api-key": "0e9baaca-e7a5-435f-bcef-62505b79f53c"},
    ).then((result) {
      var catImages = jsonDecode(result.body);
      setState(() {
        images = catImages;
      });
    });
  }

  void favorite(int index) {
    setState(() {
      var image = images[index];
      favorites.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: pageIndex == 0
          ? CardStackPage(images)
          : FavoritesPage(favorites),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Cats",
            icon: Icon(Icons.style),
          ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}