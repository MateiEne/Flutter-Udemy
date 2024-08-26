import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class SelectedPlace extends StatelessWidget {
  const SelectedPlace({
    required this.place,
    super.key,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
