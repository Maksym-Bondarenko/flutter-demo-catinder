import 'package:flutter/material.dart';

import 'main.dart';

class FavoritesPage extends StatelessWidget {
  final List favorites;
  FavoritesPage(this.favorites);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: favorites.map((i) {
          return Stack(children: [
            Image.network(
              i["url"],
              fit: BoxFit.cover,
            ),
            IconButton(
                onPressed: () {
                  favorites.remove(i);
                },
                color: Colors.white,
                icon: const Icon(Icons.heart_broken)
            ),],);
        }).toList(),
      ),
    );
  }
}